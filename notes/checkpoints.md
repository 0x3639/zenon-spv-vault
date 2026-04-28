# Embedded Checkpoints

Spec reference: `spec/spv-implementation-guide.md` §2.5 (Weak Subjectivity Considerations).

## Status (2026-04-28): shipped on the trust-hardening branch

Live in `internal/verify/checkpoints.go` of the SPV. The verifier consults `MainnetCheckpoints()` during `VerifyHeaders` for `chain_id=1` chains; a header at a checkpoint height whose hash differs from the embedded value returns `REJECT/CheckpointMismatch`.

## What checkpoints defend against

A long-range attack: an attacker who has accumulated old Pillar private keys (perhaps over years, perhaps via key rotation incidents that aren't fully understood) could rebuild an alternate chain from near genesis up to today. Without checkpoints, a fresh-start verifier following that fabricated chain would see only signed momentums that link cleanly and recompute correctly — by construction, all surface-level checks pass.

Embedded checkpoints break the attack: the fabricated chain must also reproduce the `(height, hash)` pairs the binary distribution channel ships, which the attacker cannot do unless they have the *correct* private keys for *those specific moments in time* — a strictly stronger requirement.

## Embedded values (initial pass, 2026-04-28)

Derived via `tools/derive-checkpoints --peers my.hc1node.com:35997,node.zenonhub.io:35997`:

| Height | Hash | Approx. age |
| --- | --- | --- |
| 1,000,000 | `9ac060c14855568922a877853ee347fcd68f42d354545919869d742d9f79b7f7` | ~4 months post-genesis |
| 5,000,000 | `1b151e6a51fd26f5db9fb4c4dff0777d069029d28ea3634aec3b61ff3ff8375d` | ~19 months |
| 10,000,000 | `4d3ce735eb6316de2222c5b747b84b5c5109bcaf01dde04b7143daae6d8a452c` | ~39 months |
| 13,000,000 | `00d55c7d5a49ea85fb8d0949f064b909a806afbefbb5fd93811815afa34fa528` | ~50 months |

All four agreed unanimously across both peers after local recompute (same envelope-recompute discipline as genesis).

## Verifier integration (`internal/verify/header.go`)

Per-header in `VerifyHeaders`:

1. Standard checks (chain_id, linkage, height monotonicity, hash recompute, Ed25519 signature) — Phase 1.
2. **Checkpoint check (new):** if the header's `Height` matches an entry in `MainnetCheckpoints()`, the header's `BlockHash` MUST equal the embedded `HeaderHash`. Otherwise → `REJECT/CheckpointMismatch`.
3. `// TODO(quorum)` — producer-set check (ADR 0004, deferred).

The checkpoint list is consulted only when `state.Genesis.ChainID == MainnetChainID`. Testnet/devnet/custom-checkpoint chains get an empty list (no false positives from mainnet entries).

## Trust scope

Checkpoints presume the binary distribution channel is trustworthy. A maintainer compromising the embedded list (or the build pipeline) breaks the defense at the source. Mitigating that is a release-process problem (reproducible builds, signed releases, public hash logs); out of scope for the verifier itself.

## Cadence going forward

Per ADR 0003: add a new checkpoint roughly every 1–2M momentums (~4–8 months at 10s cadence). Don't backfill density between existing entries; new history is what matters for the §2.5 defense. Each release that's at least one month behind the most recent checkpoint adds a new one near the current frontier (with appropriate safety margin).

## Sources

- spec/spv-implementation-guide.md §2.5
- decisions/0003-checkpoint-policy.md
- decisions/0004-producer-set-quorum-check.md (the related deferred work)
- internal/verify/checkpoints.go (the embedded list)
- internal/verify/header.go (the integration point)
- tools/derive-checkpoints/main.go (the maintainer derivation tool)
