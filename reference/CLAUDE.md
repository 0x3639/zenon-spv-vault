# reference/

`reference/go-zenon/` is a git submodule of `github.com/zenon-network/go-zenon`. **Read-only** — never edit files inside it. To update, run `make submodule-update` (which also rewrites the pinned-commit line below).

**Pinned commit:** `667a69d9e9a418edf7580b08492ba5dcb9efd63a` (master, as of 2026-04-28; tag-context `v0.0.8-alphanet-6-g667a69d`)

## Key packages (one-liners)

- **`chain/`** — block and momentum chain types, account pool, momentum pool. Start here for "where does X live in the data model?"
- **`chain/nom/`** — core types: `momentum.go`, `account_block.go`, protobuf definitions. The canonical structs you'll be (de)serializing in an SPV.
- **`chain/momentum/`** — momentum-chain-specific logic.
- **`chain/store/`** — persistence layer.
- **`chain/genesis/`** — genesis block construction.
- **`consensus/`** — leaderless BFT consensus implementation.
- **`p2p/`** — networking (devp2p-style; not libp2p). Relevant for understanding the current peer protocol an SPV would interoperate with.
- **`protocol/`** — wire protocol definitions.
- **`pillar/`** — full-node ("pillar") logic.
- **`vm/`** — embedded contracts (`embedded/`), ABI (`abi/`), plasma (gas) accounting.
- **`verifier/`** — block/transaction verification rules.
- **`rpc/`** — JSON-RPC API surface.
- **`wallet/`** — key management.
- **`zenon/`** — top-level coordinator wiring the above together.

## How to navigate

- **Symbol lookup:** prefer **Serena** (configured in `.mcp.json` to point at this submodule) over hand-grepping. Serena understands Go semantics and beats text search.
- **Package docs:** `cd reference/go-zenon && go doc ./chain/nom` (and similar) prints package- and symbol-level docs.
- **Editor LSP:** if you have `gopls` and want jump-to-definition, run your editor with `reference/go-zenon` as a workspace root.
- **Issue/PR archaeology:** use the **GitHub MCP** server to query closed PRs and issues on `zenon-network/go-zenon` for "why does this work this way" questions.

## Updating the pin

Re-running `make submodule-update` fast-forwards the submodule and rewrites the "Pinned commit" line above. Do not modify the pin line by hand — the script keeps it in sync with the actual checked-out commit.
