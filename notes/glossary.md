# Glossary

Format: `term — short definition — (source: ...)`. First stop when you encounter unfamiliar Zenon vocabulary.

## Terms

- **NoM (Network of Momentum)** — Zenon's overall architecture: a momentum-chain anchoring a block-lattice of per-account chains. (source: spec/architecture/architecture-overview.md §1; spec/whitepaper.md)

- **Momentum** — The consensus-anchored header object produced periodically (~10s target) that commits a snapshot of recent account-chain activity. Go struct at `reference/go-zenon/chain/nom/momentum.go:32-51`. (source: spec/greenpaper.md "Commitment Phase"; spec/spv-implementation-guide.md §3.1)

- **AccountBlock** — A per-account ledger entry (send/receive/contract). Each account has its own block-lattice; blocks reference the Momentum that committed them via `MomentumAcknowledged`. Go struct at `reference/go-zenon/chain/nom/account_block.go:83-119`. (source: spec/architecture/architecture-overview.md §2)

- **AccountHeader** — `(Address, Height, Hash)` triple — the fixed-width 60-byte digest of an account block used inside `MomentumContent`. Go struct at `reference/go-zenon/common/types/account_header.go:9-12`; serialization at line 41-46.

- **MomentumContent** — The sorted slice `[]*AccountHeader` carried inside a Momentum; `MomentumContent.Hash()` is the per-Momentum commitment field bound into the Momentum hash. (source: `reference/go-zenon/chain/nom/momentum_content.go:12, 37-39`)

- **r_C** — Spec notation for the per-Momentum commitment root over account-chain commitments at height `h`. In current go-zenon this *is* `MomentumContent.Hash()` — a flat SHA3-256, not a Merkle root. (source: spec/spv-implementation-guide.md §3.1; gap detailed in `notes/account-block-merkle-paths.md`)

- **MomentumAcknowledged** — Field on `AccountBlock` (a `types.HashHeight`) recording the Momentum height + hash the producer believes committed the block's prefix. Go field at `reference/go-zenon/chain/nom/account_block.go:91`.

- **ChainIdentifier / chain_id** — Network discriminator (mainnet vs. testnet vs. devnet). Bound into both Momentum and AccountBlock hashes; SPV pins it. (source: `chain/nom/momentum.go:34`, `chain/nom/account_block.go:85`)

- **ChangesHash** — Hash of the state-mutation patch produced by executing a Momentum. Computed full-node-side via `db.PatchHash(transaction.Changes)` (source: `verifier/momentum.go:251`). For an SPV, opaque — committed by the producer's signature but not independently recomputable without re-executing state. (source: `chain/nom/momentum.go:46`)

- **Pillar** — Staked block-producing node participating in consensus and signing Momentums. Receives ZNN emission rewards. (source: spec/architecture/architecture-overview.md §3.1)

- **Sentinel** — Planned (not yet deployed at mainnet) tier of staked nodes for proof-serving — would deliver Momentum proofs, state roots, and execution commitments to light clients. Roadmap-relevant; an SPV designed today must work *without* assuming Sentinels. (source: spec/architecture/architecture-overview.md §3.3)

- **Delegator** — Bonded ZNN holder backing a Pillar; earns a share of that Pillar's rewards. (source: spec/architecture/architecture-overview.md §3.2)

- **Policy window (`w`)** — Risk parameter chosen by the SPV operator: number of consecutive verified Momentums after a queried height required before returning ACCEPT. Recommended tiers: `w=6` low-value, `w=60` medium, `w=360` high. (source: spec/spv-implementation-guide.md §2.3)

- **Refusal semantics / REFUSED** — When evidence is missing, incomplete, or exceeds declared bounds, the verifier returns REFUSED *rather than guessing*. Distinct from REJECT (evidence present but invalid). (source: spec/spv-implementation-guide.md §1.1, §4.1)

- **Bounded verification** — The architectural frame for what an SPV can and cannot guarantee: G1 local state consistency, G2 intra-verifier temporal coherence, G3 bounded resources; NG1–NG6 enumerate explicit non-guarantees (no global validity, no canonical-chain determination, no censorship detection, etc.). (source: spec/architecture/bounded-verification-boundaries.md)

- **Genesis trust root** — Bootstrap anchor: genesis Momentum hash + chain_id + any consensus parameters needed to validate successor headers. Must ship with the verifier or be configured. (source: spec/spv-implementation-guide.md §2.1)

- **Plasma** — Zenon's gas-equivalent resource accounting; PoW or fused QSR convertible. Shows up in `AccountBlock` fields `FusedPlasma`, `BasePlasma`, `TotalPlasma`. SPV irrelevant for header verification. (source: `chain/nom/account_block.go:108-112`; spec/whitepaper.md)

- **ACI (Application Contract Interface)** — Zenon's deterministic, schema-defined contract surface (no general-purpose VM). Out of scope for header-only SPV. (source: spec/architecture/architecture-overview.md §4)

- **DetailedMomentum** — Wrapper bundling a `Momentum` with its account blocks for full-node consumption (source: `reference/go-zenon/chain/nom/momentum.go:53-56`). SPV consumes a leaner subset.

## Open questions / `TODO`

- Add terms as we hit them: pillar voting weight, leaderless BFT specifics, Embedded contracts (Token, Pillar, Sentinel, Stake, Spork, Plasma, Bridge), Plasma costs.

## Sources

Distributed inline. See `spec/`, `notes/momentum-structure.md`, `notes/account-block-merkle-paths.md`, and `reference/go-zenon/`.
