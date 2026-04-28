# SPV Proof Format

## Goal

A wire format an SPV verifier consumes to decide ACCEPT / REJECT / REFUSED for a stated fact. Must accommodate today's flat-content commitment and a forward Merkle-branch upgrade without breaking compatibility (source: spec/spv-implementation-guide.md §3, §4; decisions/0001-proof-serialization.md).

## Bundle shape (informal sketch — protobuf fields driven by ADR 0001)

```
SpvProofBundle {
    uint32 version            // wire version; bump on breaking change
    uint64 chain_id           // pin per network; rejected if mismatched
    bytes  claimed_genesis    // 32-byte Momentum hash at the trust anchor
    repeated HeaderRecord     headers           // contiguous chain extension
    repeated CommitmentEvidence commitments     // optional; one per attested AccountHeader
    repeated AccountSegment   segments          // optional; full block context
}

HeaderRecord {
    // mirror of nom.Momentum signed subset + signature/pubkey
    uint64 version, chain_id, height, timestamp_unix
    bytes  previous_hash, data_hash, content_hash, changes_hash, header_hash  // each 32B
    bytes  public_key  // 32B ed25519
    bytes  signature   // 64B ed25519
}

CommitmentEvidence {
    uint64 height                       // Momentum height
    AccountHeader target                // (address, height, hash) being attested
    oneof proof {
        FlatContentEvidence flat = 1    // current go-zenon: full sorted []AccountHeader
        MerkleBranchEvidence merkle = 2 // future: sibling hashes + index
    }
}

FlatContentEvidence  { repeated AccountHeader sorted_headers; }
MerkleBranchEvidence { repeated bytes siblings; uint64 index; }   // 32B siblings

AccountSegment {
    bytes address  // 20B
    repeated AccountBlockRecord blocks  // contiguous range; full block fields
}
```

## MVP subset

The header verifier MVP exercises only `version`, `chain_id`, `claimed_genesis`, and `headers`. `commitments` and `segments` are defined but not consumed yet. JSON encoding via `protojson` is used for human-readable test fixtures; canonical wire is protobuf bytes (source: decisions/0001-proof-serialization.md).

## Why not BIP-157 / BIP-158 filters

- BIP-157/158 target Bitcoin's UTXO model, where a wallet must blind-scan filters per block to discover its own outputs (source: external/bip-157-compact-filters.md, external/bip-158-block-filters.md — stubs).
- Zenon uses an account-chain model: every account has its own block-lattice, so an SPV with a known address performs a direct fetch (`ledger.getAccountBlocksByHeight(address, ...)`) rather than scanning filters (source: spec/architecture/architecture-overview.md §2; reference/go-zenon/rpc/api/ledger.go GetAccountBlocksByHeight at line 122).
- Filter-style retrieval may still be relevant for privacy-preserving fetch (spec §2.4), but it is *additive* to the proof bundle, not the proof itself. Out of MVP scope.

## Size budget

Per spec/spv-implementation-guide.md §6.2:

- `σ_H` (Momentum header bytes, retained subset): 0.8–1.5 KB. Our `HeaderRecord` is ~256 B raw (8 fields × ~32 B avg + signature/pubkey 96 B), padded by protobuf tagging — well within bound.
- `σ_π` (per-commitment proof): spec projects 416–640 B for a Merkle branch (`d=13–20`). Today's flat-content evidence is `60 · m` bytes per Momentum, where `m` ≈ 10³–10⁴; this is the gap surfaced in `notes/account-block-merkle-paths.md`.
- `σ_B` (per-account-block bytes): 500 B–2 KB (spec); raw protobuf of `AccountBlock` should fit at the lower end since Plasma fields and PoW nonce are fixed-width.

## Versioning policy

- `version` field bumps on any breaking change (field reorder, semantic change, new required field).
- Adding a new `oneof` arm to `CommitmentEvidence` is *not* breaking and does not bump `version`.
- A consumer that sees an unknown `version` MUST return REFUSED — never best-effort guess (source: spec/spv-implementation-guide.md §4.1 refusal semantics).

## Open questions / `TODO`

- **Canonical encoding for fixture round-trips.** Protobuf is canonical only if field ordering and default-value handling are pinned. Decision: treat protobuf bytes as canonical, JSON as debug-only. Capture in ADR 0001.
- **Compression.** Account-segment bundles for long histories may benefit from gzip; defer until measured.
- **Streaming / chunked retrieval.** A bundle larger than `MaxHeaderBytes` × `policy.W` should be chunkable. Out of MVP scope.

## Sources

- spec/spv-implementation-guide.md §3, §4.1, §6.2
- decisions/0001-proof-serialization.md
- notes/momentum-structure.md
- notes/account-block-merkle-paths.md
- reference/go-zenon/chain/nom/momentum.go:32-149
- reference/go-zenon/chain/nom/momentum_content.go:10-55
- reference/go-zenon/common/types/account_header.go:9-46
- reference/go-zenon/rpc/api/ledger.go:122 (account-block-by-height RPC)
