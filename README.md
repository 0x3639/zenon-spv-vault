# zenon-spv-vault

A local "spec vault" for Zenon SPV / light-client development. Fuses three corpora — the Zenon design papers, the [go-zenon](https://github.com/zenon-network/go-zenon) reference implementation (as a submodule), and external SPV primitives — into a single workspace an LLM agent can reason over.

## What's here

- `spec/` — design intent: papers and essays extracted from upstream.
- `reference/go-zenon/` — Zenon reference implementation (read-only submodule).
- `external/` — external primitives (Bitcoin SPV, libp2p, WebRTC, Merkle proofs).
- `notes/` — distilled understanding, with citations.
- `decisions/` — architecture decision records.
- `scripts/`, `Makefile` — automation.
- `CLAUDE.md` — agent entry point. Read this first.
- `roadmap.md` — the build plan.

## Prerequisites

- macOS or Linux
- `git`, `gh`
- Go toolchain
- Python 3.11+
- `uv` / `uvx` — `brew install uv`
- `markitdown` — `uv tool install 'markitdown[pdf]'`
- `tree` — `brew install tree`

## Quick start

```bash
git clone --recurse-submodules https://github.com/0x3639/zenon-spv-vault
cd zenon-spv-vault

# Optional: refresh spec/ from a fresh clone of the upstream prose corpus
git clone https://github.com/TminusZ/zenon-developer-commons /tmp/zenon-developer-commons
make extract                 # uses SRC=/tmp/zenon-developer-commons by default
make check SRC=/tmp/zenon-developer-commons

claude                       # opens Claude Code with the vault's MCP servers (.mcp.json)
```

If you forgot `--recurse-submodules`, run `git submodule update --init --recursive` after cloning.

## Building the SPV

The vault is the *workspace* for SPV development; the implementation itself lives in a **sibling Go module**, not here. Keeping them separate keeps spec/notes/ADR history clean and lets the vault outlive any single version of the SPV.

### Layout

```
~/Github/
├── zenon-spv-vault/    # this repo — spec, notes, decisions, MCP config
└── zenon-spv/          # SPV implementation in Go (separate repo, separate module)
```

Launch Claude Code from `zenon-spv/` and give it access to `../zenon-spv-vault/` so it can read the spec while editing implementation code. The vault's `.mcp.json` (Serena over `reference/go-zenon`, DeepWiki, GitHub MCP) is the source of truth for MCP setup — copy it into the SPV repo or run Claude from the vault with `zenon-spv/` accessible, whichever you prefer.

### Day 1 — read before you write

Follow the reading order in [`CLAUDE.md`](CLAUDE.md). In short: `spec/spv-implementation-guide.md` is authoritative; `spec/architecture/bounded-verification-boundaries.md` is a mandatory pre-read for any SPV design discussion; `notes/momentum-structure.md` and `notes/account-block-merkle-paths.md` are the distilled data-structure notes (currently stubs — see below).

### First three deliverables, in order

Do these *before* scaffolding `zenon-spv/`. They turn the vault from "scaffold" into "ready":

1. **Populate the four `notes/` stubs** (`momentum-structure.md`, `account-block-merkle-paths.md`, `spv-proof-format.md`, `glossary.md`) from real reading of `spec/` + `reference/go-zenon/`. Every fact gets a citation per `notes/CLAUDE.md`. Use Serena MCP to find the relevant symbols in go-zenon (start with `chain/nom/momentum.go` and `common/types/`).
2. **Write the first real ADR** at `decisions/0001-proof-serialization.md`. Replace the stub with an actual choice — wire format for SPV proofs, rationale rooted in the spec and go-zenon's existing serialization (`pkg/proto` and `common/types`).
3. **Scaffold `zenon-spv/`** as a fresh Go module: `go mod init github.com/0x3639/zenon-spv`. Wire up two dependencies:
   - `go get github.com/0x3639/znn-sdk-go` — primary client surface (types, RPC, ABI, crypto, PoW, wallet).
   - `go get github.com/zenon-network/go-zenon@<commit>` — fallback for chain internals the SDK doesn't expose. Pin to the **same commit** the vault has in `reference/go-zenon` (recorded in `reference/CLAUDE.md`). Bump together via `make submodule-update` + a matching `go get`.

### Recommended starting layout for `zenon-spv/`

```
zenon-spv/
├── go.mod
├── cmd/zenon-spv/        # CLI entry point
├── internal/
│   ├── verify/           # proof verification (the core — SPV's reason to exist)
│   ├── proof/            # proof wire format + (de)serialization (driven by ADR 0001)
│   ├── chain/            # momentum/account-block helpers — thin wrappers over SDK types
│   └── transport/        # libp2p / WebRTC peer wiring
└── docs/                 # short SPV-specific docs; spec lives in the vault, not here
```

### Dependency strategy

- **`znn-sdk-go` first.** Use its types, crypto, and RPC client wherever it exposes what you need. It tracks the Dart SDK and is the supported client surface — leaning on it keeps the SPV aligned with how Zenon is consumed elsewhere.
- **`go-zenon` as fallback.** Some chain internals (Merkle structures, hashing details, low-level block layout) may not be re-exported by the SDK. Import them directly from go-zenon (e.g. `common/types`, `chain/nom`), pinned to the same commit as the vault's submodule. Treat the submodule in `reference/go-zenon/` as the authoritative reading copy.
- **Reimplement only the verification layer.** The SPV's job is to verify proofs without trusting the source: Merkle path checks, momentum-chain continuity, signature verification on momentums, and the bounded-verification semantics from `spec/architecture/bounded-verification-boundaries.md`. Everything else is a dependency.
- **Cross-check.** When the SDK and go-zenon disagree (or when the SDK is silent), record it in `notes/` per the conflict-resolution policy and write an ADR if it's a hard choice.

### Using the MCP servers while building

- **Serena** — symbol/usage lookup over `reference/go-zenon`. Example: *"Where is `Momentum` defined and which packages produce or consume its hash?"*
- **DeepWiki** — high-level concept questions. Example: *"How does go-zenon's pillar consensus reach finality, and what does an SPV need to trust about it?"*
- **GitHub MCP** — issue/PR archaeology on `zenon-network/go-zenon`. Example: *"What past PRs touched account-block Merkle proofs?"*

### Feeding learning back into the vault

The vault gets smarter as you build. Standing rules:

- A non-obvious fact you discover while writing SPV code → add it to the relevant `notes/` file with a citation.
- A design choice that's hard to reverse → a new ADR in `decisions/`.
- A spec/implementation conflict → record both sides with citations; if you picked one, write an ADR.
- A type or invariant the spec is silent on → mark `TODO` in `notes/` and ask, don't invent.

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for the full contribution flow.

## Conventions

- **One commit per phase** from `roadmap.md`. Phase commits use the messages mandated there.
- **`spec/` is *derived*** — do not hand-edit. Fix `scripts/extract_pdfs.sh` and `make extract`.
- **`reference/go-zenon/` is read-only.** To bump the pin, run `make submodule-update`.
- **Cite sources** in `notes/`. Every fact ends with `(source: ...)`.
- **Surface conflicts** between `spec/` and the reference implementation in `notes/` or `decisions/`; do not silently pick one.

## MCP servers

`.mcp.json` configures three servers for Claude Code:

- **Serena** — Go-aware symbol lookup over `reference/go-zenon`.
- **DeepWiki** — high-level concept lookup against go-zenon.
- **GitHub MCP** — issue/PR archaeology on `zenon-network/go-zenon`.

## License

MIT, see `LICENSE`.

## Upstream sources

- [zenon-developer-commons](https://github.com/TminusZ/zenon-developer-commons) — design papers, the source for `spec/`.
- [go-zenon](https://github.com/zenon-network/go-zenon) — reference implementation, vendored as `reference/go-zenon`.
