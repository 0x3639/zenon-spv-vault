# 0003. Embedded Checkpoint Policy

Date: 2026-04-28

## Status

Proposed

## Context

The SPV's only embedded trust anchor before this ADR was mainnet genesis (height 1, hash `9e2046…`). For long-offline weak-subjectivity defense — `spec/spv-implementation-guide.md` §2.5 — the spec recommends shipping periodic checkpoint pairs alongside binary releases:

> If a verifier is offline for long horizons (e.g., many months to ~1 year), additional checkpoints MAY be required to prevent acceptance of a fabricated long-range fork that starts near genesis.

The threat: an attacker who has compromised many old Pillar keys could rebuild an alternate chain from near genesis up to today. With the SPV's fresh-start trust chain anchored only at height 1, that fabricated chain would type-check (hashes match, signatures match — they're "valid" by Ed25519 alone). With embedded checkpoints, the attacker's fabricated chain must also reproduce the embedded `(height, hash)` pairs, which they cannot do unless they also have the *correct* private keys for *those specific momentums* — a strictly stronger requirement.

Bitcoin Core ships `checkpoints.cpp` for the same reason. We adopt the same pattern.

Considered alternatives:

- **No checkpoints** — leave §2.5 as an open follow-up. Status quo. Rejected: the defense is mechanical and cheap, and skipping it makes long-offline operation strictly less safe than it could be.
- **Per-release dynamic checkpoint fetch.** Embed only genesis; SPV fetches recent checkpoint over network on every startup. Rejected: re-introduces single-peer trust at every startup, undoes Phase 4's offline-resume value, and shifts the weak-subjectivity hole from "long offline" to "every startup."
- **User-supplied checkpoint config.** Punt to operators. Rejected: most users won't bother, and the trust property degrades silently.
- **Hard checkpoints + hash-only verification.** Skip Ed25519 entirely; trust the checkpoint chain alone. Rejected: signatures are still useful for incremental verification between checkpoints.

## Decision

Embed `[]Checkpoint{ {Height, HeaderHash}, ... }` directly in `internal/verify/checkpoints.go` of the SPV. The verifier consults the list during `VerifyHeaders`: any header whose `Height` matches a checkpoint's height MUST have `HeaderHash` equal to the embedded entry, otherwise `REJECT/CheckpointMismatch`.

Each embedded entry is derived via `tools/derive-checkpoints`, which fetches the Momentum at the target height from ≥2 independent operators, recomputes the hash locally from the signed envelope, and asserts unanimous agreement. The maintainer re-runs the tool against current peers before each release that bumps the list and pastes the verified literal into source.

**First derivation pass (2026-04-28, peers `my.hc1node.com:35997` + `node.zenonhub.io:35997`):**

| Height | Hash | Approx. age |
| --- | --- | --- |
| 1,000,000 | `9ac060c14855568922a877853ee347fcd68f42d354545919869d742d9f79b7f7` | ~4 months post-genesis |
| 5,000,000 | `1b151e6a51fd26f5db9fb4c4dff0777d069029d28ea3634aec3b61ff3ff8375d` | ~19 months |
| 10,000,000 | `4d3ce735eb6316de2222c5b747b84b5c5109bcaf01dde04b7143daae6d8a452c` | ~39 months |
| 13,000,000 | `00d55c7d5a49ea85fb8d0949f064b909a806afbefbb5fd93811815afa34fa528` | ~50 months |

All four agreed unanimously across both peers after local recompute.

**Cadence going forward.** Add a new checkpoint roughly every 1–2M momentums (~4–8 months at 10s cadence). Don't backfill density between existing entries; new history is what matters for the §2.5 defense.

**Trust scope.** Checkpoints presume the binary distribution channel is trustworthy. A maintainer compromising the embedded list (or the build pipeline) breaks the defense at the source. Mitigating that is a release-process problem (reproducible builds, signed releases, public hash logs); out of scope for the verifier itself.

## Consequences

**Easier:**

- Long-offline verifiers detect long-range-fork attempts at the next checkpoint a fabricated chain would have to traverse.
- ADR 0002 follow-up #1 (multi-peer cross-check on embedded values) extends naturally to checkpoint derivation — same tool pattern, same recompute-then-cross-check discipline.
- A future operator in a quiet-period reorg incident can grep `mainnetCheckpoints` to bound the depth of any reorg the verifier accepts.

**Harder:**

- Each release that bumps the list requires re-running `tools/derive-checkpoints` against current peers. Maintainer discipline matters; CI cannot do this for us (RPC peers may rotate).
- A genuine deep reorg (>1M momentums in depth, exceptionally rare) past a checkpoint would require a new ADR and a new SPV release that omits or replaces that checkpoint. By design.
- An attacker who controls the binary distribution channel can ship a binary with attacker-chosen checkpoints. This is true of every embedded trust anchor including genesis itself; ADR 0002 already captures the equivalent risk for genesis.

**Off the table:**

- Auto-fetching checkpoints at runtime. Defeats the purpose.
- "Soft" checkpoints that only warn on mismatch. The whole defense is failing closed.

## Follow-ups

1. **Establish a release-time check** that every embedded `mainnetCheckpoints` entry still cross-checks against current peers. Could be a `tools/verify-anchors` umbrella tool in a later ADR.
2. **Reproducible builds + signed binaries** so that distribution-channel compromise becomes detectable. Out of this ADR's scope; tracked as a separate release-process concern.
3. **Periodic addition** of new checkpoints. Maintainer convention: every release that's at least one month behind the most recent checkpoint adds a new one near the current frontier (with appropriate safety margin).

## Sources

- spec/spv-implementation-guide.md §2.5 (Weak Subjectivity Considerations)
- decisions/0002-genesis-trust-anchor.md (the analogous ADR for genesis)
- internal/verify/checkpoints.go
- tools/derive-checkpoints/main.go
- Bitcoin Core's `src/chainparams.cpp` checkpoints (referenced for prior art)
