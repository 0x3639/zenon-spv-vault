# Momentum Structure

## What a Momentum is

- A Momentum is the consensus-anchored header that periodically commits a snapshot of recent account-block activity (source: spec/greenpaper.md §"Commitment Phase"; see also spec/architecture/architecture-overview.md §1).
- Target cadence is 10 seconds; rewards and pre-prototype resource estimates are calibrated to this interval (source: spec/greenpaper.md L1641; spec/spv-implementation-guide.md L974).

## Go struct (current implementation)

The `Momentum` struct is defined at `reference/go-zenon/chain/nom/momentum.go:32-51`. Field-level breakdown of what is and isn't covered by `Momentum.ComputeHash()` (line 58):

### Fields included in the hash (signed bytes)

The `JoinBytes(...)` argument list at `chain/nom/momentum.go:59-68` is the canonical signed envelope:

| Order | Field | Encoding | Notes |
| --- | --- | --- | --- |
| 1 | `Version` | `common.Uint64ToBytes` | Protocol version. |
| 2 | `ChainIdentifier` | `common.Uint64ToBytes` | Chain ID; SPV must pin per network. |
| 3 | `PreviousHash` | 32 bytes | Links to parent Momentum. |
| 4 | `Height` | `common.Uint64ToBytes` | Strictly monotonic per chain. |
| 5 | `TimestampUnix` | `common.Uint64ToBytes` | Seconds since epoch. |
| 6 | `types.NewHash(Data)` | 32 bytes | Hash of raw `Data` payload, not raw `Data`. |
| 7 | `Content.Hash()` | 32 bytes | Per-Momentum commitment over account headers (see below). |
| 8 | `ChangesHash` | 32 bytes | Hash of state-mutation patch (see "Open questions"). |

Hashing primitive is SHA3-256: `types.NewHash` wraps `crypto.Hash`, which uses `sha3.New256()` (source: `reference/go-zenon/common/types/hash.go:18-21` and `reference/go-zenon/common/crypto/hash.go:9-15`).

### Fields NOT included in the hash (added after signing)

- `Hash` (cached value of `ComputeHash`, stored on the struct).
- `Timestamp *time.Time` (cache of `TimestampUnix`).
- `producer *types.Address` (cache of `PubKeyToAddress(PublicKey)`).
- `PublicKey ed25519.PublicKey` — Ed25519 public key of the producing Pillar.
- `Signature []byte` — Ed25519 signature over `Hash.Bytes()`.

(source: `reference/go-zenon/chain/nom/momentum.go:36-50`, comments on each field.)

## Signature scheme

- Ed25519 over the 32-byte `Hash`. Verification call: `wallet.VerifySignature(momentum.PublicKey, momentum.Hash.Bytes(), momentum.Signature)` (source: `reference/go-zenon/verifier/momentum.go:241`).
- `wallet.VerifySignature` is a thin wrapper over `crypto/ed25519.Verify` with a key-length check (source: `reference/go-zenon/wallet/crypto.go:59-64`).
- The producing address is derived as `types.PubKeyToAddress(PublicKey)` (source: `reference/go-zenon/chain/nom/momentum.go:86`).

## How a Momentum references account blocks

- The `Content` field is `MomentumContent`, an alias for `[]*types.AccountHeader` (source: `reference/go-zenon/chain/nom/momentum_content.go:12`).
- An `AccountHeader` is `(Address, Height, Hash)` triple (source: `reference/go-zenon/common/types/account_header.go:9-12`); its `Bytes()` is `address || uint64(height) || hash` (line 41-46).
- `MomentumContent.Hash()` is a flat SHA3-256 of the concatenated, sorted `AccountHeader.Bytes()` (source: `reference/go-zenon/chain/nom/momentum_content.go:29-39`). Sort order: lexicographic on `AccountHeader.Bytes()` (source: line 47, `AccountBlockHeaderComparer`).
- Therefore, today the per-Momentum commitment ("r_C" in spec/spv-implementation-guide.md §3.1) is **not** a Merkle tree — it is an O(m) flat hash. See `notes/account-block-merkle-paths.md` for the spec-vs-impl gap.

## Cadence enforcement

- Cadence target (10s) is documented in spec/greenpaper.md L1641; the enforcement mechanism (consensus scheduling for Pillar producers) lives under `reference/go-zenon/consensus/`. Detailed scheduling rules are out of scope for SPV verification — an SPV does not re-derive the producer set at MVP scope.

## Open questions / `TODO`

- **`ChangesHash` semantics.** Full nodes set `ChangesHash = db.PatchHash(transaction.Changes)` (source: `reference/go-zenon/verifier/momentum.go:251`), where `Changes` is the state-mutation patch produced by executing the Momentum. An SPV cannot recompute this without re-executing state transitions, so it must treat `ChangesHash` as an opaque 32-byte value committed by the producer's signature. `TODO`: confirm whether any SPV-level invariant is derivable from `ChangesHash` alone.
- **Producer-set / quorum check.** The current verifier delegates this to `mv.producer(transaction)` (source: `reference/go-zenon/verifier/momentum.go:227`), which depends on consensus state an SPV does not maintain. The SPV MVP performs only the single-key Ed25519 check; quorum-aware verification is a follow-up. `TODO`: write ADR `0003-quorum-verification.md` once we know what subset of consensus state an SPV must shadow.
- **Re-orgs and finality.** The `bounded-verification-boundaries.md` (G2, NG6) frame says an SPV cannot determine the canonical chain. The MVP treats whichever momentum chain the verifier last anchored to as authoritative within its policy window `w`. `TODO`: capture observed reorg depths from mainnet to justify `w` per spec §D.4.

## Sources

- `spec/greenpaper.md` (cadence; commitment-phase definition)
- `spec/spv-implementation-guide.md` §3.1 (verifier-required header subset)
- `reference/go-zenon/chain/nom/momentum.go:32-69`
- `reference/go-zenon/chain/nom/momentum_content.go:12-49`
- `reference/go-zenon/common/types/hash.go:18-21`
- `reference/go-zenon/common/types/account_header.go:9-46`
- `reference/go-zenon/common/crypto/hash.go:9-15`
- `reference/go-zenon/wallet/crypto.go:59-64`
- `reference/go-zenon/verifier/momentum.go:232-249`
