# 0004. Producer-Set / Quorum Signature Check

Date: 2026-04-28

## Status

Proposed (deferred — design recorded; implementation out of scope for the trust-hardening branch)

## Context

`bounded-verification-boundaries.md` §4 lists "unforgeable validator or quorum signatures" as a required assumption for the architecture's G1 (Local State Consistency) guarantee. Today the SPV's signature check is incomplete:

- Per-momentum: `ed25519.Verify(public_key, header_hash, signature)`. Confirms *some* keypair signed it.
- Missing: confirm that `public_key` is a member of the active Pillar producer set at `height`.

A `// TODO(quorum)` marker has stood in `internal/verify/header.go` since Phase 1 and now also in `internal/verify/segment.go`. With each subsequent phase the gap has grown more visible: the watch loop verifies thousands of momentums per day and every one of them passes a check that admits *any* well-formed Ed25519 signature — including one from an attacker-generated keypair, as long as the attacker also fabricates the rest of the envelope to recompute correctly.

What actually matters for G1: the signature must come from a Pillar that the consensus quorum recognizes as legitimate at that height. That requires the SPV to maintain enough state to evaluate "is this public key in the active Pillar set at height H?"

Considered approaches:

1. **Shadow the entire Pillar registry.** Fetch + verify every Pillar registration / unregistration / spork update from genesis to current. Most accurate, also most code. Re-implements a substantial chunk of `pkg/embedded/pillar` from go-zenon.
2. **Trust a snapshot of the Pillar set per epoch + verify epoch transitions.** Treat Pillar set changes as discrete events the SPV can verify in batch. Requires understanding Zenon's epoch / spork mechanics.
3. **Defer to a trusted oracle peer.** A canonical full node publishes "the active Pillar public keys at height H" and the SPV trusts that peer with multi-peer cross-check. Lighter weight; reintroduces the single-peer trust hole multi-peer cross-check is meant to close.
4. **Signed validator set in checkpoints.** Each embedded `Checkpoint` (ADR 0003) carries the active Pillar set hash at that height. Between checkpoints, the SPV trusts that the set didn't change. Only works if Pillar rotation is rare enough that ~1M-height intervals capture all of it.
5. **Defer indefinitely with an explicit caveat.** Document that ACCEPT is conditioned on producer-set-validity-not-checked, treat the defense as out-of-band (operator must vet trusted peers and accept the Ed25519 layer is consistency-only).

## Decision

**Defer the implementation; record the design here so it's tracked, not silently missing.** The trust-hardening branch (ADR 0003) lands the cheap, well-defined defenses (multi-peer genesis attestation, embedded checkpoints) and explicitly excludes producer-set verification because it requires shadowing a non-trivial subset of Zenon consensus state — multi-week effort that warrants its own design review.

The intended target design is approach **(2): epoch-based Pillar set verification**, with a fallback to approach (4) if Pillar rotation events are rare enough to be checkpoint-aligned. Concrete steps for the future implementation:

1. Read `pkg/embedded/pillar` and the spork machinery in go-zenon to understand how Pillar set changes are committed.
2. Define an `ActivePillarSet` shape in `internal/chain` capturing what the SPV must shadow.
3. Extend `internal/proof` with `PillarSetEvidence` (analogous to `CommitmentEvidence`) — the wire format for "here's the Pillar set at height H, with a recompute path."
4. Add `internal/verify.VerifyPillarSet(state, evidence) -> Result` and call it from `VerifyHeaders` in place of (or alongside) the current naked Ed25519 check.
5. Update `tools/derive-checkpoints` to also derive the `ActivePillarSet` at each checkpoint height, and embed those in `mainnetCheckpoints` per option (4).
6. Update `bounded-verification-boundaries.md` cross-references in `docs/conformance.md` so G1's status reflects the new check.

In the meantime, `docs/conformance.md` already lists this as a known MVP gap, and ACCEPT carries the documented caveat.

## Consequences

**Easier (once implemented):**

- The G1 guarantee from `bounded-verification-boundaries.md` becomes substantively true rather than aspirational.
- An attacker who compromises a single Ed25519 keypair (but not the active Pillar set's collective signing capability) can no longer fabricate momentums that pass the verifier.
- ACCEPT's documented caveat shrinks from "some keypair signed this" to "an active Pillar signed this."

**Harder:**

- The SPV must track Pillar set state across epoch boundaries. Bounded-verification's G3 (bounded resource usage) still holds — the active-Pillar set is small (~30 entries at mainnet's current cadence) — but the SPV's "what is state" surface grows.
- Each release that lags a Pillar rotation needs a corresponding update to embedded set anchors (per option 4) or fresh epoch verification (per option 2). Tooling matters.

**Off the table (until implemented):**

- The G1 guarantee in its full strength. Today it's degraded to "some Ed25519 keypair signed this." An ADR superseding this one will land alongside the actual implementation.

## Follow-ups

1. **Choose the design path** (option 2 vs option 4 hybrid) once go-zenon's Pillar mechanics are read in detail.
2. **Spike branch** with the chosen approach implemented against testnet first.
3. **Integration ADR** that supersedes this one and lands the actual mechanism.
4. **Conformance update** in `docs/conformance.md` and `bounded-verification-boundaries.md` cross-refs.

## Sources

- spec/architecture/bounded-verification-boundaries.md §4 (the "Unforgeable validator or quorum signatures" assumption)
- spec/spv-implementation-guide.md §1.1, §10
- internal/verify/header.go (the standing `TODO(quorum)`)
- internal/verify/segment.go (also `TODO(quorum)`)
- decisions/0003-checkpoint-policy.md (option-4 piggybacks on this ADR's checkpoint mechanism)
- reference/go-zenon/embedded/pillar (where the actual Pillar registry lives in go-zenon)
