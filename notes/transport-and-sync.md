# Transport and Sync Loop

Spec reference: `spec/spv-implementation-guide.md` §5 (Verification flows — bootstrap, account event, offline resume) and §9.1 (Adversarial scenario analysis — multi-peer redundancy).

## Status (2026-04-28): Phase 5a shipped, Phase 5b deferred

**Phase 5a — verifier-as-service.** Live in `internal/syncer/` of the implementation repo, wired via the `zenon-spv watch` CLI subcommand. The verifier loads (or initializes) persistent state, then ticks at a configurable interval, multi-peer-fetching new momentums and verifying them with k-of-n redundancy. State persists after each ACCEPT. SIGINT/SIGTERM cause graceful shutdown.

**Phase 5b — libp2p / WebRTC peer protocol.** Deferred. Building a Zenon-specific light-client sub-protocol on top of libp2p is a multi-month project (custom request/response messages, peer discovery, gossip semantics, browser integration via WebRTC). The current transport — HTTPS JSON-RPC against operator endpoints — is what every Zenon RPC node deploys today. The watch loop is structured so swapping `fetch.MultiClient` for a libp2p-based concrete type later is a local change.

## Loop semantics

Per `internal/syncer.Loop.Run`:

1. **Startup.** Load `HeaderState` from `--state`; refuse to bootstrap from empty state (the loop cannot anchor against genesis with ~13M intervening momentums on faith — pre-anchor via `verify-headers --genesis-config <checkpoint>` first).
2. **Per tick.**
   1. `MultiClient.FetchFrontierAtAgreedHeight(safetyMargin)` — query each peer's frontier in parallel, take `min(frontiers) - safetyMargin` as the agreed target.
   2. If `target ≤ tip` → ACCEPT/caught-up, no fetch.
   3. Otherwise, fetch `tip+1..min(target, tip+batchSize)` via `MultiClient.FetchByHeight` (cross-peer agreed).
   4. `verify.VerifyHeaders` against the loaded state.
   5. On ACCEPT, `verify.SaveHeaderState` atomically. On REJECT/REFUSED, the state file is untouched (Phase 4 invariant).
3. **Pacing.** If the loop made progress and is still behind by more than `batchSize`, fire the next tick immediately (catch-up mode). Otherwise wait `interval` until the next tick.
4. **Shutdown.** On `ctx.Done()`, return cleanly.

## End-to-end smoke (2026-04-28)

Pre-anchored at tip 13,126,652 via `verify-headers --genesis-config cp.json --state watch.state bundle.json`. Ran `zenon-spv watch --peers my.hc1node.com,node.zenonhub.io --interval 5s --batch-size 30 ...` for 35 seconds:

```
watching: tip=13126652, peers=2, quorum=2, interval=5s
tick: ACCEPT tip=13126652 -> 13126662 (fetched 10, target=13126662)
tick: ACCEPT (caught up at tip=13126662, frontier_target=13126662)
tick: ACCEPT tip=13126662 -> 13126663 (fetched 1, target=13126663)
tick: ACCEPT (caught up at tip=13126663, frontier_target=13126663)
tick: ACCEPT tip=13126663 -> 13126664 (fetched 1, target=13126664)
tick: ACCEPT (caught up at tip=13126664, frontier_target=13126664)
tick: ACCEPT tip=13126664 -> 13126665 (fetched 1, target=13126665)
```

13 momentums verified across 8 ticks (2 catch-up batches + per-momentum extension at the live cadence). Two-peer cross-check active throughout.

## Configuration

Flags map directly onto `syncer.Loop` fields:

| Flag | Default | Notes |
| --- | --- | --- |
| `--peers <urls>` | env `ZENON_SPV_PEERS` | Comma-separated; multi-peer with k-of-n agreement. |
| `--rpc <url>` | env `ZENON_SPV_RPC` | Single-peer fallback if `--peers` omitted. |
| `--quorum <k>` | `len(peers)` | Minimum agreeing peers; default = unanimous. |
| `--state <path>` | (required) | Persistent HeaderState. |
| `--genesis-config <path>` | embedded mainnet | Trust root for state initialization. |
| `--window {low\|medium\|high}` | low | Maps to `policy.W` ∈ {6, 60, 360}. |
| `--interval <dur>` | 10s | Time between ticks at steady state. |
| `--safety-margin <n>` | 6 | Stay this many momentums behind `min(frontiers)`. |
| `--batch-size <n>` | 60 | Cap on headers fetched per tick (catch-up bound). |

## Refusal-rate observability

Each tick emits one log line. Categories from spec §10:

- `ACCEPT (caught up ...)` — no work.
- `ACCEPT tip=A -> B (fetched N, target=...)` — verified extension.
- `REFUSED ReasonMissingEvidence ...` — peer-side fetch failure or quorum disagreement (cross-peer).
- `REFUSED ReasonWindowNotMet ...` — should not happen at steady state since the loop fetches `policy.W` worth of headers; will if `policy.W` was bumped between runs.
- `REJECT ReasonInvalid* ...` — peer served structurally bad data; loop continues but state is untouched. This would surface a peer compromise immediately.

## Open follow-ups

- **Phase 5b: libp2p / WebRTC peer protocol.** Tracked as future work; needs a Zenon community process to define a light-client sub-protocol first.
- **Hot peer-set updates.** Today the watch loop's peer list is fixed at startup. Adding/removing peers without restart is a small refactor.
- **Refusal-rate aggregation.** Currently one line per tick; emit a periodic histogram (per spec §10's measurement mandate) for production deployments.
- **Producer-set / quorum signature** is still `// TODO(quorum)` in `internal/verify/header.go` — orthogonal to this phase but increasingly visible as the watch loop verifies more momentums.

## Sources

- `spec/spv-implementation-guide.md` §1.1, §5, §9.1, §10.
- `internal/syncer/syncer.go` and `internal/syncer/syncer_test.go`.
- `cmd/zenon-spv/main.go` (the `watch` subcommand).
- Phase 4 persistence: `notes/header-state-persistence.md`.
- Multi-peer cross-check: `internal/fetch/multi.go`.
