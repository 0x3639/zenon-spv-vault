# Zenon Spec Vault — Build Roadmap

> **Audience:** This document is written for Claude Code (or another coding agent) working alongside the human owner. Read it top-to-bottom before starting. Each phase has explicit acceptance criteria; do not skip ahead.

---

## 0. Context

We are building a local "spec vault" — a single git repository that fuses three corpora into something an LLM can reason over while writing Zenon-related code (specifically, an SPV/light-client implementation):

1. **Design intent** — the prose corpus at `github.com/TminusZ/zenon-developer-commons` (PDFs, markdown essays, GitBook mirror).
2. **Reference implementation** — `github.com/zenon-network/go-zenon` (Go source).
3. **External primitives** — Bitcoin SPV (BIP-157/158, Neutrino), libp2p, WebRTC, Merkle proof libraries.

The vault is the canonical workspace for SPV development. It is also the deliverable: anyone who clones it should be able to run `claude` and be productive immediately.

A secondary deliverable, built in Phase 5, is a small MCP server (`zenon-spec-mcp`) that exposes vault-aware tools to any MCP client.

### Operating principles

- **Spec is design intent; go-zenon is current reality.** When they disagree, surface the conflict — do not silently pick one.
- **Markdown over PDF.** PDFs are not agent-readable. Every PDF must have a faithful markdown counterpart.
- **CLAUDE.md is the entry point.** Every meaningful directory gets one. Agents read these first.
- **Notes accumulate.** As we learn things from go-zenon or the spec, we write them down in `notes/`. The vault gets smarter over time.
- **Don't over-engineer the MCP.** Phase 5 is optional and only built once we've felt the pain of not having it.

### Working environment assumptions

- macOS (primary) and Linux (secondary). Code paths under `~/Github/`.
- `zsh`, Brave browser.
- Local tools already installed: `markitdown`, `git`, `gh`, Go toolchain, Python 3.11+, `uv`/`uvx`.
- Claude Code is the primary agent. Optional secondary clients: Claude Desktop, Cursor.

---

## 1. Repository layout (target state)

By the end of Phase 4 the vault should look like this:

```
zenon-spv-vault/
├── CLAUDE.md                    # root entry-point: reading order + policy
├── README.md                    # human-facing overview
├── .mcp.json                    # MCP server config (Serena, DeepWiki, GitHub)
├── .gitignore
├── LICENSE                      # MIT
├── Makefile                     # convenience targets
│
├── spec/                        # extracted design-intent prose
│   ├── CLAUDE.md                # reading order for the papers
│   ├── greenpaper.md
│   ├── purplepaper.md
│   ├── indigopaper.md
│   ├── orangepaper.md
│   ├── lightpaper.md
│   ├── whitepaper.md
│   ├── spv-implementation-guide.md
│   ├── essays/
│   │   ├── bitcoins-unfinished-constraint-i.md
│   │   ├── bitcoins-unfinished-constraint-ii.md
│   │   ├── bitcoins-unfinished-constraint-iii.md
│   │   ├── ghost-in-the-ledger.md
│   │   ├── the-empty-quadrant.md
│   │   └── the-question-no-one-bothered-to-ask-bitcoin.md
│   └── architecture/
│       ├── bounded-verification-boundaries.md
│       └── architecture-overview.md
│
├── reference/
│   ├── CLAUDE.md                # how to navigate go-zenon
│   └── go-zenon/                # git submodule, READ-ONLY
│
├── external/                    # external primitives, summarized
│   ├── CLAUDE.md
│   ├── bip-157-compact-filters.md
│   ├── bip-158-block-filters.md
│   ├── neutrino-spv.md
│   ├── libp2p-overview.md
│   ├── libp2p-webrtc-transport.md
│   ├── webrtc-datachannel.md
│   └── merkle-proofs-primer.md
│
├── notes/                       # our evolving distilled understanding
│   ├── CLAUDE.md
│   ├── momentum-structure.md
│   ├── account-block-merkle-paths.md
│   ├── spv-proof-format.md
│   └── glossary.md
│
├── decisions/                   # ADRs (architecture decision records)
│   ├── CLAUDE.md
│   ├── template.md
│   └── 0001-proof-serialization.md
│
├── scripts/                     # automation: PDF→MD, vault checks
│   ├── extract_pdfs.sh
│   ├── refresh_submodule.sh
│   └── check_vault.py
│
└── tools/
    └── zenon-spec-mcp/          # Phase 5 — optional MCP server
        ├── README.md
        ├── pyproject.toml
        ├── src/zenon_spec_mcp/
        │   ├── __init__.py
        │   ├── server.py
        │   ├── search.py
        │   └── index.py
        └── tests/
```

---

## 2. Phases

### Phase 1 — Bootstrap the vault (target: 30 minutes)

**Goal:** Skeleton repo on disk with all source material cloned.

1. Create `~/Github/zenon-spv-vault/` and `git init` it.
2. Add `LICENSE` (MIT), a placeholder `README.md`, and a `.gitignore` that excludes `.DS_Store`, `__pycache__/`, `.venv/`, `node_modules/`, and `tools/zenon-spec-mcp/.index/`.
3. Create the directory skeleton from §1 (empty `CLAUDE.md` files allowed for now).
4. Add `reference/go-zenon` as a **git submodule** pointing at `https://github.com/zenon-network/go-zenon`. Pin to a specific commit; record that commit hash in `reference/CLAUDE.md`.
5. Clone `https://github.com/TminusZ/zenon-developer-commons` to a temp location (`/tmp/zenon-developer-commons`). It is the *source* for Phase 2. We do **not** vendor it — the vault contains derived markdown only.
6. Initial commit: "Phase 1: scaffold vault."

**Acceptance criteria**

- `tree -L 2` matches the layout in §1 (minus the populated content).
- `git submodule status` shows `reference/go-zenon` at a pinned commit.
- `git log` has one commit.

---

### Phase 2 — Extract the prose corpus (target: 60–90 minutes)

**Goal:** Every PDF and markdown file in zenon-developer-commons has a faithful, agent-readable markdown counterpart in `spec/`.

1. Write `scripts/extract_pdfs.sh`. It takes one argument (the source repo path) and runs `markitdown` over each PDF, writing output into `spec/`. Map filenames as follows (kebab-case, drop `ZENON_` prefix):
   - `1_ZENON_LIGHTPAPER_(CORE_TEAM).pdf` → `spec/lightpaper.md`
   - `2_ZENON_WHITEPAPER_(CORE_TEAM).pdf` → `spec/whitepaper.md`
   - `ZENON_GREENPAPER.pdf` → `spec/greenpaper.md`
   - `ZENON_GREENPAPER_SPV_IMPLEMENTATION_GUIDE.pdf` → `spec/spv-implementation-guide.md`
   - `ZENON_INDIGOPAPER.pdf` → `spec/indigopaper.md`
   - `ZENON_PURPLEPAPER.pdf` → `spec/purplepaper.md`
   - `ZENON_ORANGEPAPER_DRAFT_V1.pdf` → `spec/orangepaper.md`
   - `ZENON_WHITEPAPER_DECODED:EXPANDED_COMMUNITY_PAPER.pdf` → `spec/whitepaper-decoded.md`
   - Cover letters → `spec/cover-letters/<name>.md`
2. Copy the markdown essays into `spec/essays/` with kebab-case names (lowercase, hyphens, no apostrophes — e.g. `BITCOIN'S_UNFINISHED_CONSTRAINT.md` → `bitcoins-unfinished-constraint-i.md`).
3. Copy `docs/architecture/bounded-verification-boundaries.md` and `docs/architecture/architecture-overview.md` into `spec/architecture/`.
4. **Quality pass.** MarkItDown will mangle some pages — diagrams, tables, equations, footnotes. For each output file:
   - Compare against the source PDF.
   - If a section is materially broken, flag it with an HTML comment at the top: `<!-- QUALITY: equations on p.14 lost in extraction; refer to original PDF -->`.
   - Do **not** silently fix prose. Faithful-to-source beats prettified.
5. Commit: "Phase 2: extract spec corpus."

**Acceptance criteria**

- Every PDF in the source repo has a corresponding `.md` in `spec/`.
- Running `wc -l spec/**/*.md` shows non-trivial line counts (no zero-byte files).
- `grep -r 'QUALITY:' spec/` enumerates known extraction issues.

---

### Phase 3 — Write the navigation layer (target: 60 minutes)

**Goal:** `CLAUDE.md` files at the root and in each top-level directory tell an agent where to look and in what order.

#### Root `CLAUDE.md`

Must contain, in this order:

1. **One-paragraph project description.** What this vault is, what it is not.
2. **Reading order for SPV work.** Numbered list of files to consult, in priority order:
   1. `spec/spv-implementation-guide.md` (authoritative)
   2. `spec/greenpaper.md` (verification model)
   3. `spec/architecture/bounded-verification-boundaries.md` (mandatory pre-read)
   4. `notes/momentum-structure.md` and `notes/account-block-merkle-paths.md`
   5. `reference/go-zenon/` (use Serena/grep for symbol lookup)
   6. `external/bip-157-compact-filters.md`, `external/neutrino-spv.md` for adjacent designs
3. **Conflict-resolution policy.** Verbatim: *"When the spec and the implementation disagree, the spec is design intent and go-zenon is current reality. Surface the conflict in `notes/` or `decisions/`; do not silently pick one."*
4. **What to do when stuck.** Try DeepWiki MCP, then GitHub MCP for issue/PR archaeology, then ask the human.
5. **What not to do.** Do not edit files in `reference/go-zenon/` (it's read-only). Do not edit files in `spec/` (they are derived from PDFs — re-run extraction instead). Do not invent facts to fill gaps; mark them `TODO` and ask.
6. **Glossary pointer.** "Unfamiliar term? Check `notes/glossary.md` first."

#### Per-directory `CLAUDE.md`

- `spec/CLAUDE.md` — the canonical reading order *within* the paper series (greenpaper → purplepaper → indigopaper → orangepaper, per the upstream README), with a one-line summary of what each paper covers.
- `reference/CLAUDE.md` — pinned commit hash; key packages in go-zenon and what they do (one-liners); how to use `go doc` and `gopls`.
- `external/CLAUDE.md` — purpose of each external primitive and which Zenon concept it informs.
- `notes/CLAUDE.md` — these are *our* notes, edit freely; format is "fact + source citation".
- `decisions/CLAUDE.md` — ADR format: Context / Decision / Consequences. Use `template.md`.

7. Commit: "Phase 3: navigation layer."

**Acceptance criteria**

- Every directory listed in §1 has a `CLAUDE.md`.
- Root `CLAUDE.md` answers: "I'm starting work on SPV; what do I read?"
- An agent given only the root `CLAUDE.md` can find every other relevant file within two hops.

---

### Phase 4 — Wire up MCP clients and seed initial notes (target: 60–90 minutes)

**Goal:** Claude Code, on `cd zenon-spv-vault && claude`, has Serena, DeepWiki, and GitHub MCP available, and there are enough seeded notes that the first real SPV question is productive.

1. Create `.mcp.json` at the repo root with three servers:
   - **Serena**, configured to point at `reference/go-zenon` (use the `uvx --from git+https://github.com/oraios/serena serena-mcp-server` invocation; pass the project path).
   - **DeepWiki** at `https://mcp.deepwiki.com/mcp` (or current URL — verify against `docs.devin.ai/work-with-devin/deepwiki-mcp`).
   - **GitHub MCP server** (`github.com/github/github-mcp-server`) — for issue and PR archaeology on go-zenon. Use the official remote-hosted endpoint if available; otherwise document the local docker setup.
2. Add a `Makefile` with targets:
   - `make extract` — re-run `scripts/extract_pdfs.sh` against a configurable source path.
   - `make submodule-update` — fast-forward `reference/go-zenon` and update the pin in `reference/CLAUDE.md`.
   - `make check` — run `scripts/check_vault.py` (see step 4).
   - `make tree` — print a depth-2 tree of the vault.
3. Seed the `notes/` directory with **stubs**, not invented content. Each file should have a structure like:

   ```markdown
   # Momentum Structure

   <!-- Stub. Populate by reading spec/greenpaper.md §X and reference/go-zenon/chain/nom/momentum.go -->

   ## Open questions
   - What fields are signed vs. unsigned?
   - How is the momentum hash computed?

   ## Sources
   - TODO
   ```

   Stub files: `momentum-structure.md`, `account-block-merkle-paths.md`, `spv-proof-format.md`, `glossary.md`.
4. Write `scripts/check_vault.py` — a small Python script that asserts:
   - Every directory in §1 exists and has a `CLAUDE.md`.
   - Every PDF in the upstream source has a matching `.md` in `spec/` (takes the source path as an argument).
   - `reference/go-zenon` is a git submodule and the pin in `reference/CLAUDE.md` matches `git submodule status`.
   - No file in `spec/` is zero bytes.
   Exit non-zero on failure; print a diff-style summary.
5. Write a real `README.md` (human-facing): what the vault is, prerequisites, quick start (`git clone --recurse-submodules`, `make extract`, `claude`), license, link to upstream sources.
6. Commit: "Phase 4: MCP config, makefile, vault checks."

**Acceptance criteria**

- `make check` passes.
- Opening Claude Code in the vault root lists Serena, DeepWiki, and GitHub MCP as available.
- A test query — e.g. "Where is `Momentum` defined in go-zenon?" — returns a precise file/line answer via Serena.

---

### Phase 5 — Optional: build `zenon-spec-mcp` (defer until needed)

**Goal:** A small FastMCP server that exposes vault-aware tools. **Do not start this phase until Phases 1–4 have been used for real work for at least a week** and the human has identified concrete repeat-prompts that would be replaced by tools.

Likely tool surface (confirm with human before implementing):

- `search_spec(query: str, top_k: int = 5)` — semantic search across `spec/` and `notes/`. Returns ranked snippets with file paths and section headers.
- `get_section(file: str, section: str)` — fetch a specific section of a markdown file by heading.
- `list_papers()` — return the paper series with one-line summaries (driven by `spec/CLAUDE.md`).
- `find_conflict(concept: str)` — return both the spec passage and the matching go-zenon symbol(s) for a concept; useful for surfacing spec-vs-impl drift.
- `list_open_questions()` — scrape `notes/` and `decisions/` for `TODO` and "Open questions" sections.

Implementation sketch:

1. Use FastMCP (`pip install fastmcp`).
2. Build a local index with sentence-transformer embeddings stored in SQLite (`sqlite-vec` or `sqlite-vss`). Keep it under `tools/zenon-spec-mcp/.index/` and gitignore it.
3. Index command: `zenon-spec-mcp index --vault ../..` (re-runnable, idempotent).
4. Server entry point: `zenon-spec-mcp serve` (stdio transport for local Claude Code; HTTP optional).
5. Test with `pytest`. Cover at least: index build is deterministic, `search_spec` returns expected snippets for a known query, `get_section` handles missing sections gracefully.
6. Add the server to `.mcp.json`.
7. Commit: "Phase 5: zenon-spec-mcp v0.1."

**Acceptance criteria**

- `zenon-spec-mcp index` completes without error and produces an index under `.index/`.
- `zenon-spec-mcp serve` starts and responds to MCP `tools/list`.
- Claude Code, with the server connected, can answer "find me the section in any paper that discusses unilateral exit" in one tool call.

---

### Phase 6 — Publish (target: 30 minutes, after Phases 1–4)

1. Push to a public GitHub repo. Suggested name: `zenon-spv-vault`.
2. README must call out that go-zenon is a submodule and instruct cloners to use `--recurse-submodules`.
3. Add a CONTRIBUTING.md describing how to add new notes and ADRs.
4. Tag `v0.1.0` once Phases 1–4 are complete.

---

## 3. Standing instructions for the agent

- **Ask before destructive actions.** Anything that rewrites `spec/` from scratch, force-pushes, or modifies the submodule pin — confirm with the human first.
- **Never edit `reference/go-zenon/`.** It's a submodule; treat it as read-only. To update, run `make submodule-update`.
- **Cite sources in notes.** Every fact in `notes/` should end with a citation: `(source: spec/greenpaper.md §3.2)` or `(source: reference/go-zenon/chain/nom/momentum.go:L142)`.
- **When the spec is silent, say so.** Don't paper over gaps with plausible-sounding fiction. Mark `TODO` and ask.
- **One commit per phase.** Use the commit messages specified in each phase. If a phase is split across sessions, prefix subsequent commits with the phase number.
- **PDF re-extraction is destructive.** If `make extract` is re-run, manually-fixed sections in `spec/` will be overwritten. The fix is to improve the extraction script, not to hand-edit `spec/`. (Notes go in `notes/`.)

---

## 4. Definition of done (overall)

The vault is "done enough to start writing the SPV" when:

- Phases 1–4 acceptance criteria all pass.
- The human can clone the repo on a fresh machine, run two commands, and have a working agent setup.
- A new contributor can read the root `CLAUDE.md` and know where to look for any SPV-related question.
- At least three real `notes/*.md` files have been populated from actual reading of the spec + go-zenon.
- One real ADR exists in `decisions/` (e.g. `0001-proof-serialization.md`) reflecting an actual choice made.

Phase 5 (custom MCP) and Phase 6 (publish) are gravy.

---

## 5. Out of scope (for now)

- Implementing the SPV itself. This roadmap builds the *workspace* for that work.
- Vendoring zenon-developer-commons content beyond the markdown extracts.
- Hosting the MCP server publicly. Local stdio is sufficient.
- Auto-generated wikis (DeepWiki already does this; no need to duplicate).
- Embedding-based search over go-zenon source. Serena + gopls is better for code.

---

## 6. References

- Zenon Developer Commons: https://github.com/TminusZ/zenon-developer-commons
- go-zenon: https://github.com/zenon-network/go-zenon
- Serena MCP: https://github.com/oraios/serena
- DeepWiki: https://deepwiki.com (MCP at https://mcp.deepwiki.com)
- GitHub MCP: https://github.com/github/github-mcp-server
- FastMCP: https://github.com/jlowin/fastmcp
- MarkItDown: https://github.com/microsoft/markitdown