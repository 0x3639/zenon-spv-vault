# decisions/

Architecture Decision Records (ADRs) for the SPV design. One ADR per real, irreversible-ish design choice. ADRs are append-only history — when a decision changes, write a new ADR that supersedes the old one; do not edit the original.

## Format

Each ADR follows `template.md`:

- **Context** — what's the problem, what constrains the choice.
- **Decision** — what we chose, in one paragraph.
- **Consequences** — what becomes easier, what becomes harder, what's now off the table.

## Naming

`NNNN-short-kebab-case-title.md`, where `NNNN` is a zero-padded sequential number. The first real ADR is `0001-`.

## When to write one

Write an ADR when:

- A design choice will be hard to reverse later (proof format, wire schema, transport).
- The spec is silent and we picked a path; we want to record *why* so future you doesn't relitigate.
- `spec/` and `reference/go-zenon/` disagree and we picked one (per the conflict-resolution policy in the root `CLAUDE.md`).

Don't write one for routine implementation choices that the next refactor could easily undo.
