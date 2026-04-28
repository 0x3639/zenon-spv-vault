# Contributing

This vault is a workspace for Zenon SPV / light-client development. Contributions are welcome — most of them will land in `notes/` or `decisions/`.

Read [`CLAUDE.md`](CLAUDE.md) and [`roadmap.md`](roadmap.md) before opening a PR.

## Ground rules

- **Do not edit `spec/`.** It is derived from upstream PDFs by `scripts/extract_pdfs.sh`. Fix the script (or improve the upstream PDF) and re-run `make extract`. Hand-edits will be lost.
- **Do not edit `reference/go-zenon/`.** It is a pinned, read-only submodule. To bump the pin, run `make submodule-update` and update the commit hash in `reference/CLAUDE.md` in the same commit.
- **Do not invent facts.** When the spec is silent or ambiguous, mark `TODO` in `notes/` and say so. Plausible-sounding fiction is worse than an admitted gap.
- **Surface conflicts.** When `spec/` and `reference/go-zenon/` disagree, record both with citations. Do not silently pick one.

## Adding a note

Notes live under `notes/`. They are our distilled understanding of the spec and the reference implementation, and they accumulate over time.

1. Pick the right file. Existing files are scoped (`momentum-structure.md`, `account-block-merkle-paths.md`, `spv-proof-format.md`, `glossary.md`). Add a new file only if your topic doesn't fit any of them.
2. Write facts, not paragraphs. Each fact ends with a citation:
   - `(source: spec/greenpaper.md §3.2)`
   - `(source: reference/go-zenon/chain/nom/momentum.go:L142)`
   - `(source: https://github.com/zenon-network/go-zenon/pull/123)`
3. When you answer an item from the file's "Open questions" section, move it into the body (with a citation) and remove it from the list.
4. If a new note file is added, link it from `notes/CLAUDE.md`.

## Adding an ADR

Architecture Decision Records live under `decisions/`. Use them for design choices that will be hard to reverse — proof format, wire schema, transport — or for moments where `spec/` and `reference/go-zenon/` disagree and we picked a path.

1. Copy `decisions/template.md` to `decisions/NNNN-short-kebab-case-title.md`, where `NNNN` is the next zero-padded sequential number.
2. Fill in **Status**, **Context**, **Decision**, and **Consequences**. Keep each section short and specific.
3. ADRs are append-only history. To change a decision, write a new ADR that supersedes the old one and update the old one's Status to `Superseded by NNNN`. Do not rewrite the original.
4. Don't write an ADR for routine implementation choices the next refactor could undo.

## Updating the spec corpus

`make extract SRC=/path/to/zenon-developer-commons` re-runs the PDF→Markdown pipeline. If the output regresses for a specific paper, fix `scripts/extract_pdfs.sh` rather than the output. Re-run `make check SRC=...` afterward.

## Bumping the go-zenon submodule

```
make submodule-update
```

This fast-forwards `reference/go-zenon` to upstream `master`, prints the new commit hash, and reminds you to update the pin in `reference/CLAUDE.md`. Commit the submodule bump and the `reference/CLAUDE.md` change together.

## Before opening a PR

- Run `make check SRC=/path/to/zenon-developer-commons` and confirm all four checks pass.
- Keep commits focused. Roadmap-phase commits use the messages mandated in `roadmap.md`; ad-hoc commits should describe the *why*, not just the *what*.
- If you touched `spec/`, you almost certainly meant to touch `scripts/extract_pdfs.sh` instead. Double-check.
