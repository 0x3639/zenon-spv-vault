# Account-Block Merkle Paths

## Spec expectation

- The SPV implementation guide assumes binary Merkle membership proofs of size `O(log m)` under the per-Momentum commitment root `r_C`, where `m` is the number of commitments (account blocks) per Momentum (source: spec/spv-implementation-guide.md §3.2).
- The guide explicitly assumes a binary Merkle tree with SHA-256 hashes (source: spec/spv-implementation-guide.md §3.2.1) and computes proof sizes as `σ_π ≈ 32 · d` where `d = ceil(log₂ m)`.

## Implementation reality (go-zenon @ commit 667a69d)

- There is no Merkle tree. The per-Momentum commitment is `MomentumContent.Hash()`, a single flat SHA3-256 over the byte-concatenation of sorted `AccountHeader` records (source: `reference/go-zenon/chain/nom/momentum_content.go:29-39`).
- Each `AccountHeader` is `address(20B) || height(8B) || hash(32B)` = 60 bytes (source: `reference/go-zenon/common/types/account_header.go:41-46` and `chain/nom/momentum_content.go:10`).
- Sort order is lexicographic over `AccountHeader.Bytes()` (source: `chain/nom/momentum_content.go:51-55`).
- The Momentum commits to this flat hash as its 7th signed field (source: `chain/nom/momentum.go:66`, slot `m.Content.Hash().Bytes()`).
- Hashing primitive is SHA3-256, not SHA-256 (source: `reference/go-zenon/common/crypto/hash.go:9-15`).

## Implications for the SPV

- **No `O(log m)` membership proof exists today.** To verify that a given `(address, height, hash)` triple is included under `r_C(h)`, an SPV must receive the full sorted `MomentumContent` slice for height `h`, recompute `MomentumContent.Hash()`, and check it equals the `Content` hash bound into the Momentum hash.
- **Bandwidth scales O(m), not O(log m).** With ~10⁴ commitments per Momentum at 60 bytes each, the per-Momentum content payload is ~600 KB versus the spec's projected ~448 B Merkle branch. This must be surfaced in the SPV's resource accounting (`σ_π` in spec §3.4) and in any "fits within bounds" decision the verifier makes.
- **REFUSED on bound exceedance.** Per refusal semantics (spec/spv-implementation-guide.md §4.1, §7), an SPV that has declared a bandwidth bound below the O(m) threshold MUST return REFUSED rather than skip the membership check.
- **AccountBlock membership is verified at the header level only.** The SPV can prove that an `AccountHeader` (address, height, account-block-hash) is committed; verifying the *full* AccountBlock additionally requires fetching the block and re-deriving its `ComputeHash()` (source: `chain/nom/account_block.go:176-195`).

## Wire-format consequence

- The proof bundle must carry the full sorted `[]AccountHeader` slice for each Momentum height that the verifier touches. See `notes/spv-proof-format.md` and `decisions/0001-proof-serialization.md`.
- The bundle is designed with a `oneof` discriminator so a future Merkle-branch mode is additive, not breaking, when go-zenon (or a Sentinel layer) starts publishing tree-shaped commitments.

## What an SPV verifies for an account-chain segment

For a contiguous segment `B_A[i..j]` of account `A` (spec §3.3), the SPV must:

1. Fetch the segment + each block's `MomentumAcknowledged` (source: `chain/nom/account_block.go:91`).
2. Re-derive `block.ComputeHash()` and compare to `block.Hash` for each block.
3. Verify account-chain linkage: for every `k`, `B_A[k].PreviousHash == B_A[k-1].Hash` and `B_A[k].Height == B_A[k-1].Height + 1`.
4. For each `MomentumAcknowledged` referenced, verify the matching Momentum is present in the verifier's authenticated header window (anchored by `VerifyHeaders`).
5. For each block, verify its `AccountHeader` (`address, height, block.Hash`) appears in the corresponding `MomentumContent` slice — i.e., recompute `MomentumContent.Hash()` and check against the Momentum's bound `Content` hash.
6. Verify each block's Ed25519 signature using the same wallet/crypto path as Momentum verification (source: `wallet/crypto.go:59`).

The MVP scope (this phase) implements only step 4 — the header chain — and stubs steps 5–6 for a follow-up phase.

## Sources

- `spec/spv-implementation-guide.md` §3.2, §3.2.1, §3.3, §3.4, §4.1, §7
- `reference/go-zenon/chain/nom/momentum.go:32-69`
- `reference/go-zenon/chain/nom/momentum_content.go:10-55`
- `reference/go-zenon/chain/nom/account_block.go:83-195`
- `reference/go-zenon/common/types/account_header.go:9-46`
- `reference/go-zenon/common/crypto/hash.go:9-15`
- `decisions/0001-proof-serialization.md` (this gap drives the wire-format choice)
