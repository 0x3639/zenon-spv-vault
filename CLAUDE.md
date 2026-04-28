# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this vault is

A local "spec vault" that fuses three corpora into a workspace an LLM can reason over while writing Zenon SPV / light-client code: design intent (the prose papers under `spec/`), reference implementation (`reference/go-zenon/`, a pinned read-only submodule of `github.com/zenon-network/go-zenon`), and external primitives (Bitcoin SPV, libp2p, WebRTC, Merkle proofs — under `external/`). The vault is *not* the SPV implementation itself; it's the workspace for that work.

## Reading order for SPV work

When starting work on SPV, consult these files in order:

1. `spec/spv-implementation-guide.md` — authoritative implementation guide.
2. `spec/greenpaper.md` — verification model.
3. `spec/architecture/bounded-verification-boundaries.md` — **mandatory pre-read** for any SPV design discussion.
4. `notes/momentum-structure.md` and `notes/account-block-merkle-paths.md` — distilled understanding of the data structures involved.
5. `reference/go-zenon/` — use Serena (or `grep`/`gopls`) for symbol lookup; do not skim packages by hand.
6. `external/bip-157-compact-filters.md` and `external/neutrino-spv.md` — adjacent designs worth borrowing from.

## Conflict-resolution policy

When the spec and the implementation disagree, the spec is design intent and go-zenon is current reality. Surface the conflict in `notes/` or `decisions/`; do not silently pick one.

## What to do when stuck

1. Try **DeepWiki MCP** for high-level concept lookup against go-zenon.
2. Try **GitHub MCP** for issue/PR archaeology on `zenon-network/go-zenon`.
3. Ask the human.

## What not to do

- **Do not edit files in `reference/go-zenon/`.** It's a pinned submodule — read-only. To update, run `make submodule-update`.
- **Do not edit files in `spec/`.** They are derived from upstream PDFs by `scripts/extract_pdfs.sh`. To change them, fix the script or improve the upstream PDF, then re-run extraction. Manual edits will be lost on the next `make extract`.
- **Do not invent facts to fill gaps.** When the spec is silent, mark `TODO` in `notes/` and ask. Plausible-sounding fiction is worse than an admitted gap.
- **Do not push without confirmation.** Pushing to `origin` publishes the work; always confirm with the human first.

## Glossary

Unfamiliar term? Check `notes/glossary.md` first.

## Phase / commit convention

Work is organized into phases with explicit acceptance criteria in `roadmap.md`. One commit per phase, using the message specified in each phase. If a phase is split across sessions, prefix subsequent commits with the phase number.
