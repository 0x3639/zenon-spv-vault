# notes/

These are *our* notes — distilled understanding of the spec and the implementation, written down so the vault gets smarter over time. Edit freely.

## Format

Each fact ends with a citation. Examples:

- `Momentums chain at a 10-second cadence (source: spec/greenpaper.md §3.2).`
- `The genesis block is constructed via NewGenesisBlock() (source: reference/go-zenon/chain/genesis/genesis.go:L42).`

When you record a fact:

- **Cite the source.** Spec section, file:line, or upstream issue/PR. No source = not a fact.
- **Mark gaps explicitly.** Use `TODO`. Don't paper over silence in the spec with plausible reconstructions.
- **Surface conflicts.** When `spec/` and `reference/go-zenon/` disagree, write down both, cite both, and move the resolution into `decisions/` if it's a design choice.

## Files

- **`momentum-structure.md`** — what a momentum is, what's signed, how the hash is computed.
- **`account-block-merkle-paths.md`** — account-block Merkle proof shape; what an SPV verifies.
- **`spv-proof-format.md`** — wire format for SPV proofs; serialization.
- **`glossary.md`** — Zenon-specific terms. First stop when you encounter unfamiliar vocabulary.

## Open questions

Each note file has an "Open questions" section. Treat those as a backlog — when you answer one (with a real source citation), move it from "Open questions" into the body and remove it from the list.
