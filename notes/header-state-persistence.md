# Header-State Persistence

Spec reference: `spec/spv-implementation-guide.md` §1.1 ("Offline resilience: a verifier can resume from its last verified header and cached proofs") and §5 (Offline-resume flow).

## Status (2026-04-28): shipped

Live in `internal/verify/state_file.go` of the implementation repo. Wired into all three `verify-*` CLI subcommands via the `--state <path>` flag.

## What is persisted

A small JSON file (`stateFileVersion = 1`) carrying:

- `version` — schema version (refused if unknown, per ADR 0001's discipline).
- `genesis` — the trust root the state is bound to (chain_id + height + 32-byte hash).
- `retained_window` — the last `policy.W` verified `chain.Header` records.
- `capacity` — the retained-window capacity at last save.

Crash-safe write: temp file in the same directory + `fsync` + atomic `rename`. A torn file on disk is impossible on any modern POSIX FS.

## Behavior matrix

| Flag | File present | Behavior |
| --- | --- | --- |
| `--state` set | yes | Load the persisted state. Trust root must match `--genesis-config` (or env). Mismatch → fatal error. Bundle's `claimed_genesis` is informational on resume; the persisted `Genesis` is authoritative. |
| `--state` set | no | Initialize fresh from the configured trust root. Persist after a successful ACCEPT. |
| `--state` set | yes | On REJECT or REFUSED, the file is **not** rewritten — the persisted state is unchanged. |
| `--state` omitted | n/a | Ephemeral, no persistence (Phase 1–3 behavior). |

## Replay-attack defense (verified 2026-04-28)

End-to-end smoke against mainnet:

1. Run 1: `verify-headers --genesis-config cp.json --state spv.state run1_bundle.json` → ACCEPT. Tip persisted at h=13,125,941.
2. Run 2: same `--state`, fetch heights `tip+1..tip+6` → ACCEPT. Tip → 13,125,947.
3. Run 3: same again → ACCEPT. Tip → 13,125,953.
4. **Replay**: feed run 1's bundle (heights 13,125,936..13,125,941) a second time → REJECT/BrokenLinkage. Tip stays at 13,125,953. The persisted state cannot be rolled back by an attacker who replays an older bundle.

The replay defense is structural: `VerifyHeaders` anchors on `state.Tip()` if the retained window is non-empty. A replay's first header's `previous_hash` cannot match the current tip (it links to a past tip), so linkage check fires before anything else.

## Trust-root binding

The state file embeds its `Genesis`. On `LoadOrInit(path, configured_genesis, policy)`:

- Different `chain_id` → fatal error ("refuse to mix networks").
- Different `header_hash` → fatal error ("different trust roots").
- `policy.W` shrunk since save → most-recent-W headers retained, older ones dropped.
- `policy.W` grown → window remains short until new headers are appended.

This is what catches the "I configured my mainnet verifier with the wrong genesis" footgun.

## Open follow-ups

- **Long-offline weak-subjectivity** (§2.5). If the persisted state is older than ~1 year, reorgs reconstructing history beyond the retained window become a real concern. Spec recommends shipping periodic checkpoint pairs alongside binary releases. Track via a future ADR.
- **Multi-state-file workflows.** A single SPV process today watches one trust root at a time. Watching multiple chains (mainnet + testnet) simultaneously requires either separate state files per chain or a per-chain index in a single file. Defer until a real use case appears.
- **Compaction for long retention.** At `WindowHigh = 360` headers, the file is ~150–500 KB depending on σ_H. Trivially small today; revisit if we ever need offline retention well beyond `policy.W`.

## Sources

- spec/spv-implementation-guide.md §1.1, §2.5, §5
- decisions/0001-proof-serialization.md (versioning discipline)
- decisions/0002-genesis-trust-anchor.md (the anchor the persisted state binds to)
- internal/verify/state_file.go
- internal/verify/state_file_test.go (round-trip + atomic-rename + chain_id/genesis-mismatch coverage)
