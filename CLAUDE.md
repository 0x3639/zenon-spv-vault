# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Current state: pre-Phase-1

This repo is a planned "spec vault" for Zenon SPV / light-client development. The only file present is `roadmap.md`. The vault's directory layout, scripts, Makefile, MCP config, and per-directory `CLAUDE.md` files do not yet exist — they are produced by executing the phases in `roadmap.md`.

**Before doing anything else, read `roadmap.md` top-to-bottom.** It is written specifically for the coding agent and contains the build plan, target layout, acceptance criteria, and standing instructions. This file is a thin pointer to it; the roadmap is the source of truth.

Once Phase 3 lands, the root `CLAUDE.md` is meant to be replaced with the navigation layer specified in `roadmap.md` §2 Phase 3. Until then, this bootstrap file applies.

## What this vault is (and isn't)

A single git repo fusing three corpora so an LLM can reason over them while writing SPV code:

1. **Design intent** — prose extracted from `github.com/TminusZ/zenon-developer-commons` (PDFs → markdown) under `spec/`.
2. **Reference implementation** — `github.com/zenon-network/go-zenon` as a read-only git submodule under `reference/go-zenon/`.
3. **External primitives** — Bitcoin SPV (BIP-157/158, Neutrino), libp2p, WebRTC, Merkle proofs, summarized under `external/`.

It is *not* the SPV implementation itself — it's the workspace for that work.

## Operating principles (from `roadmap.md`)

- **Spec is design intent; go-zenon is current reality.** When they disagree, surface the conflict in `notes/` or `decisions/` — do not silently pick one.
- **Markdown over PDF.** PDFs are not agent-readable. Every PDF gets a faithful markdown counterpart via `markitdown`; faithful-to-source beats prettified.
- **`spec/` is derived, not authored.** Do not hand-edit files in `spec/` — they come from PDF extraction. Fix the extraction script and re-run instead. Manual notes go in `notes/`.
- **`reference/go-zenon/` is read-only.** It's a submodule. To update, run `make submodule-update` (once the Makefile exists in Phase 4).
- **Notes accumulate; cite sources.** Every fact in `notes/` ends with a citation, e.g. `(source: spec/greenpaper.md §3.2)` or `(source: reference/go-zenon/chain/nom/momentum.go:L142)`.
- **When the spec is silent, say so.** Mark `TODO` and ask the human. Don't invent plausible-sounding fiction to fill gaps.

## Standing constraints

- **Don't skip ahead.** Phases are ordered with explicit acceptance criteria. Complete and commit each phase before starting the next. One commit per phase, using the commit messages specified in `roadmap.md`.
- **Phase 5 (custom MCP) is deferred** until Phases 1–4 have been used for real work for at least a week. Don't start it preemptively.
- **Ask before destructive actions** — rewriting `spec/` from scratch, force-pushing, or moving the submodule pin all require human confirmation.
- **PDF re-extraction is destructive.** Re-running `make extract` overwrites `spec/`; any hand-edits there will be lost.

## Environment assumptions

macOS primary, Linux secondary. `zsh`. Tools assumed installed: `markitdown`, `git`, `gh`, Go toolchain, Python 3.11+, `uv`/`uvx`. Code paths under `~/Github/`.

## Commands

None yet — the `Makefile` and `scripts/` are produced in Phase 4. Once they exist, the standard targets will be `make extract`, `make submodule-update`, `make check`, `make tree`.
