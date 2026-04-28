# 0001. SPV Proof Serialization

Date: 2026-04-28

## Status

Proposed

## Context

The SPV needs a canonical wire format for proof bundles passed between peers (and between phases of the verifier itself: file fixtures → CLI → verifier core). The format is hard to reverse later — once peers and proof archives ship binaries that emit a particular schema, every subsequent change is a migration. So this is the right kind of choice for an ADR.

Constraints:

1. **Round-trip with go-zenon types.** `Momentum`, `AccountBlock`, `AccountHeader`, and `Hash` already serialize via protobuf in go-zenon (source: `reference/go-zenon/chain/nom/momentum.go:102-148`, `reference/go-zenon/common/types/account_header.go:18-39`). Reusing protobuf preserves byte-equivalence for fields we copy through and lets us share message definitions where useful.
2. **Accommodate the Merkle gap.** Today, the per-Momentum commitment is a flat SHA3-256 of sorted `AccountHeader` records (source: `reference/go-zenon/chain/nom/momentum_content.go:37-39`); the spec assumes O(log m) Merkle proofs (source: spec/spv-implementation-guide.md §3.2). The wire format must let us carry "flat-content evidence" today and Merkle-branch evidence tomorrow without a breaking schema change. See `notes/account-block-merkle-paths.md` for full detail.
3. **Schema-versioned.** Refusal semantics (spec/spv-implementation-guide.md §4.1) require deterministic outcomes; an unknown-version proof must REFUSE, not best-effort parse.
4. **Agent-readable for fixtures.** Test vectors live in `internal/testdata/`; humans (and Claude) need to be able to read and tweak them.
5. **Minimal new build-time surface.** Avoid pulling in ecosystems we don't already use.

Considered alternatives:

- **JSON only.** Ergonomic, no schema, slow to validate, and field-order ambiguity defeats canonical-bytes hashing if the format is ever signed. Rejected as canonical wire; kept as debug encoding.
- **RLP** (Ethereum-style). No schema, alien to the Zenon ecosystem, no `oneof` analogue without manual tagging. Rejected.
- **Cap'n Proto / FlatBuffers.** Zero-copy is irrelevant at our message sizes; introduces an unfamiliar toolchain. Rejected.
- **Protobuf3.** Already used by go-zenon for the structurally identical types we're carrying through (`MomentumProto`, `AccountBlockProto`, `AccountHeaderProto`). `oneof` natively expresses the Merkle-vs-flat dichotomy. `protojson` gives a human-readable JSON sibling encoding for free.

## Decision

Use **protobuf3** as the canonical wire format for SPV proof bundles. The top-level message is `SpvProofBundle`, with an explicit `version` field and a `oneof` discriminator for commitment evidence so the future Merkle migration is additive rather than breaking.

```proto
syntax = "proto3";
package zenon.spv.v1;

message SpvProofBundle {
  uint32 version          = 1;   // wire version; bump on any breaking change
  uint64 chain_id         = 2;   // pinned per network
  bytes  claimed_genesis  = 3;   // 32-byte Momentum hash at the trust anchor
  repeated HeaderRecord       headers     = 4;
  repeated CommitmentEvidence commitments = 5;  // optional; empty for header-only bundles
  repeated AccountSegment     segments    = 6;  // optional; empty for header-only bundles
}

message HeaderRecord {
  uint64 version          = 1;
  uint64 chain_id         = 2;
  uint64 height           = 3;
  uint64 timestamp_unix   = 4;
  bytes  previous_hash    = 5;   // 32B
  bytes  data_hash        = 6;   // 32B
  bytes  content_hash     = 7;   // 32B
  bytes  changes_hash     = 8;   // 32B
  bytes  header_hash      = 9;   // 32B; claimed; verifier recomputes and compares
  bytes  public_key       = 10;  // 32B ed25519
  bytes  signature        = 11;  // 64B ed25519
}

message CommitmentEvidence {
  uint64 height               = 1;
  AccountHeaderRecord target  = 2;
  oneof proof {
    FlatContentEvidence  flat   = 3;  // current go-zenon
    MerkleBranchEvidence merkle = 4;  // future
  }
}

message FlatContentEvidence  { repeated AccountHeaderRecord sorted_headers = 1; }
message MerkleBranchEvidence { repeated bytes siblings = 1; uint64 index = 2; }

message AccountHeaderRecord { bytes address = 1; uint64 height = 2; bytes hash = 3; }

message AccountSegment {
  bytes address = 1;
  repeated AccountBlockRecord blocks = 2;  // contiguous range
}

message AccountBlockRecord { /* mirror of nom.AccountBlock signed subset + sig + pubkey */ }
```

JSON fixtures use `protojson` so the same `.proto` is the single source of truth. Canonical bytes for any signed/hashed proof artefact are protobuf-marshaled bytes with deterministic field ordering as guaranteed by `proto.MarshalOptions{Deterministic: true}`.

The MVP scaffold ships the `HeaderRecord` portion only; `CommitmentEvidence` and `AccountSegment` are defined but unused until later phases. The header verifier consumes `version + chain_id + claimed_genesis + headers` only.

`version = 1` for the initial release. Bumping rules:

- Adding a `oneof` arm to `CommitmentEvidence` (e.g., `merkle` once go-zenon publishes Merkle proofs) does not bump `version`.
- Adding optional fields with new tag numbers does not bump `version`.
- Reordering fields, repurposing tag numbers, or changing semantics of existing fields requires a new ADR and bumps `version`.

## Consequences

**Easier:**

- Wire-compatible with go-zenon's existing serialization style; we can copy raw bytes for fields like `Momentum.PreviousHash` without recoding.
- Future Merkle migration is additive — a new `oneof` arm, no breaking change for existing flat-content bundles.
- `protojson` gives readable test fixtures without a second schema.
- Deterministic bytes from `proto.MarshalOptions{Deterministic: true}` make any future "sign the whole bundle" use case mechanical.

**Harder:**

- Adds a `protoc` (or `buf`) build-time step. The SPV repo gains a `tools/` or `proto/` directory and a `make proto` target.
- Field reorders or tag-number reuses are forbidden — implementers need to know this. Documented in this ADR.
- Schema lives in two places eventually (this ADR sketches it; the SPV repo's `proto/` is canonical). Resolved by having this ADR point at the SPV's `proto/spv.proto` once it lands and treating the proto file as authoritative.

**Off the table:**

- JSON as canonical wire format. JSON survives only as a debug/fixture encoding emitted by `protojson`.
- Hand-rolled RLP-style encoding. We do not invent a fourth Zenon serialization format.

## Sources

- spec/spv-implementation-guide.md §3, §4.1
- notes/momentum-structure.md
- notes/account-block-merkle-paths.md
- notes/spv-proof-format.md
- reference/go-zenon/chain/nom/momentum.go:102-148
- reference/go-zenon/chain/nom/momentum_content.go:14-39
- reference/go-zenon/common/types/account_header.go:18-39
