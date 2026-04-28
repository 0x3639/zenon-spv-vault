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
