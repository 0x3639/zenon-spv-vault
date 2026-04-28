# spec/

Derived from upstream `github.com/TminusZ/zenon-developer-commons` via `scripts/extract_pdfs.sh`. **Do not hand-edit these files.** Fix the extraction script and re-run instead.

## Paper reading order

Per the upstream README, read the paper series in this order:

1. **`greenpaper.md`** — Verification-First Architecture for Dual-Ledger Systems. Defines the verification model that everything else builds on.
2. **`purplepaper.md`** — extends the greenpaper into the consensus and dual-ledger mechanics.
3. **`indigopaper.md`** — deeper dive into the architectural primitives.
4. **`orangepaper.md`** — Scaling Bitcoin Through Verification-First Interoperability (largest paper, most recent thinking).

Companion documents:

- **`spv-implementation-guide.md`** — practical SPV implementation guide; treat as authoritative for SPV work.
- **`whitepaper.md`** — original 2020 Network of Momentum whitepaper (Zenon core team).
- **`whitepaper-decoded.md`** — community-authored expanded reading of the original whitepaper.
- **`lightpaper.md`** — high-level summary (image-based source PDF; see QUALITY note).

## Architecture (`architecture/`)

- **`bounded-verification-boundaries.md`** — mandatory pre-read for any SPV design discussion. The conceptual frame for what an SPV client can and cannot verify. Note: upstream filename is `bounded-verification-boundries.md` (typo in upstream); we corrected the spelling on copy.
- **`architecture-overview.md`** — high-level architectural sketch.

## Cover letters (`cover-letters/`)

Author-signed cover letters that frame the corresponding papers. Useful for original intent and authorship context, less so for implementation details.

## Essays (`essays/`)

Six essays vendored from the upstream root:

- **`bitcoins-unfinished-constraint-{i,ii,iii}.md`** — three-part series on Bitcoin's verification constraint.
- **`ghost-in-the-ledger.md`** — why AI haunts execution-first chains.
- **`the-empty-quadrant.md`** — the design-space gap Zenon targets.
- **`the-question-no-one-bothered-to-ask-bitcoin.md`** — framing essay.

The upstream repo has additional essays (Alien Architecture series, Interstellar series, etc.) that are *not* vendored here. Pull them from `github.com/TminusZ/zenon-developer-commons` on demand if needed.

## Quality flags

`spec/lightpaper.md` and `spec/whitepaper.md` carry `<!-- QUALITY: ... -->` comments documenting known extraction issues. Run `grep -r 'QUALITY:' spec/` to enumerate.
