# 0002. Embedded Mainnet Genesis Trust Anchor

Date: 2026-04-28

## Status

Proposed

## Context

The SPV's first verification step anchors to a genesis Momentum hash and chain identifier (spec/spv-implementation-guide.md §2.1). Until now, the SPV required `--genesis-config` or env-var configuration on every invocation; running with no config returned `ErrGenesisNotConfigured`. That is conservative but inconvenient: a wallet user should not have to source a 32-byte hex blob to run the verifier, and the verifier should not pretend that "no opinion" is a security improvement when the answer is in fact knowable and recompuable.

Bitcoin Core, Neutrino, and every other production light-client embed mainnet genesis directly in the source. We should do the same.

The mainnet genesis Momentum was fetched from `https://my.hc1node.com:35997` via `ledger.getMomentumByHash` on 2026-04-28. We recomputed `Momentum.ComputeHash` from the signed envelope of the response (header fields + SHA3-256 of the sorted account-header content + SHA3-256 of the data field) and confirmed the recomputed hash equals the peer-claimed hash:

```
9e204601d1b7b1427fe12bc82622e610d8a6ad43c40abf020eb66e538bb8eeb0
```

See `notes/mainnet-genesis.md` for the full recomputation.

The recomputation defends against the peer flipping the hash on us — a peer can't claim a hash inconsistent with the signed fields it served. It does *not* defend against the peer fabricating an entire alternate genesis with internally-consistent fields. That requires a multi-peer cross-check.

Constraints that shaped the choice:

1. **Production light-clients embed.** Operators expect this.
2. **Single-peer trust is bounded by recomputation.** Embedding a recomputed-and-checked hash is strictly stronger than blindly trusting a hash literal someone pasted into a config file.
3. **Cross-checking is a separate, additive concern.** It is the obvious follow-up but should not block embedding.
4. **Override path must remain.** Testnet, devnet, and operator-pinned anchors must still be configurable.

Considered alternatives:

- **Continue requiring `--genesis-config`.** Worse UX for negligible security gain, since the operator-supplied hash is no more verified than the embedded one (in fact less, since most operators won't recompute).
- **Embed and skip recomputation.** Cuts a real defense for ~50 lines of work; not worth it.
- **Embed multiple sources up front (cross-check now).** Best long-term, but the second-source operator wasn't named in this conversation. Track as follow-up rather than block on it.

## Decision

Embed `9e204601d1b7b1427fe12bc82622e610d8a6ad43c40abf020eb66e538bb8eeb0` (chain_id=1, height=1) as a `const` mainnet genesis trust root in `internal/verify/genesis.go` of the SPV. `MainnetGenesis()` returns the embedded value with no error. The CLI defaults to it; `--genesis-config <path>` and `ZENON_SPV_GENESIS_HASH`+`ZENON_SPV_CHAIN_ID` env vars override.

The recomputation script and proof live in `notes/mainnet-genesis.md`; future SPV releases that bump go-zenon should re-run the recompute and confirm the embedded hash is unchanged. A failure to recompute (e.g., spec change to the hash envelope) is a release-blocking event that triggers a new ADR.

## Consequences

**Easier:**

- Wallet users run `zenon-spv verify-headers <bundle.json>` with no config.
- `MainnetGenesis()` returns deterministic state; tests can assert specific values.
- Recomputation proof is a known artifact future maintainers can reproduce.

**Harder:**

- Bumping go-zenon now requires re-running the recompute and confirming the embedded hash. Worth it; this is a feature, not a tax.
- A discovered fork or chain replay would require a new ADR (and a new version of the SPV) to update the embedded hash. We accept this — anchors should be hard to change.

**Off the table:**

- Treating the embedded hash as authoritative without recomputation. The recompute is part of the trust chain; remove it and the embed becomes a trust-the-source-blob anti-pattern.

## Follow-ups

1. **Multi-peer cross-check.** Fetch the same genesis from ≥2 independent operators (different ASN, different geography). Update `notes/mainnet-genesis.md` with the cross-check matrix. If any operator disagrees, write a new ADR; do not silently pick one.
2. **Periodic checkpoint pairs.** Per spv-implementation-guide.md §2.5, ship `(height, hash)` checkpoint pairs alongside genesis on each release to defend against long-range attacks for long-offline verifiers. Future ADR.
3. **Testnet / devnet anchors.** When testnet support lands, embed those anchors too with the same recompute discipline. Track in their own ADRs (`0003-testnet-trust-anchor.md`, etc).

## Sources

- `notes/mainnet-genesis.md` (recompute proof + raw RPC fields).
- `reference/go-zenon/chain/nom/momentum.go:58-69` (`Momentum.ComputeHash`).
- `reference/go-zenon/chain/nom/momentum_content.go:29-55` (`MomentumContent.Hash`).
- spec/spv-implementation-guide.md §2.1, §2.5, §9 (genesis anchoring + weak subjectivity).
- decisions/0001-proof-serialization.md (the wire format embedded headers must conform to).
