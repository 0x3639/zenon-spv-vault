#!/usr/bin/env bash
# Re-derives spec/ content from a local clone of github.com/TminusZ/zenon-developer-commons.
# Runs markitdown on each PDF and copies the listed markdown essays + architecture docs.
# Idempotent: overwrites existing outputs. Manual edits to spec/ will be lost on re-run.
#
# Usage: scripts/extract_pdfs.sh <path-to-zenon-developer-commons>

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <path-to-zenon-developer-commons>" >&2
  exit 1
fi

SRC="$1"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ ! -d "$SRC" ]; then
  echo "Error: source dir not found: $SRC" >&2
  exit 2
fi

if ! command -v markitdown >/dev/null 2>&1; then
  echo "Error: markitdown not installed (try: uv tool install 'markitdown[pdf]')" >&2
  exit 3
fi

mkdir -p "$ROOT/spec/essays" "$ROOT/spec/architecture" "$ROOT/spec/cover-letters"

# PDF -> markdown via markitdown.
# Format: SOURCE_BASENAME|TARGET_RELATIVE_TO_VAULT_ROOT
PDFS=(
  "1_ZENON_LIGHTPAPER_(CORE_TEAM).pdf|spec/lightpaper.md"
  "2_ZENON_WHITEPAPER_(CORE_TEAM).pdf|spec/whitepaper.md"
  "ZENON_GREENPAPER.pdf|spec/greenpaper.md"
  "ZENON_GREENPAPER_SPV_IMPLEMENTATION_GUIDE.pdf|spec/spv-implementation-guide.md"
  "ZENON_INDIGOPAPER.pdf|spec/indigopaper.md"
  "ZENON_PURPLEPAPER.pdf|spec/purplepaper.md"
  "ZENON_ORANGEPAPER_DRAFT_V1.pdf|spec/orangepaper.md"
  "ZENON_WHITEPAPER_DECODED:EXPANDED_COMMUNITY_PAPER.pdf|spec/whitepaper-decoded.md"
  "3_ZENON_GREENPAPER_COVER_LETTER_TO_COMMUNITY.pdf|spec/cover-letters/greenpaper-to-community.md"
  "4_ZENON_GREENPAPER_COVER_LETTER.pdf|spec/cover-letters/greenpaper.md"
  "ZENON_INDIGOPAPER_COVER_LETTER.pdf|spec/cover-letters/indigopaper.md"
  "ZENON_PURPLEPAPER_COVER_LETTER.pdf|spec/cover-letters/purplepaper.md"
)

# Essays at the upstream root (NOT in essays/ — that dir holds the broader collection we don't vendor).
ESSAYS=(
  "BITCOIN'S_UNFINISHED_CONSTRAINT.md|spec/essays/bitcoins-unfinished-constraint-i.md"
  "BITCOIN'S_UNFINISHED_CONSTRAINT_PART_II.md|spec/essays/bitcoins-unfinished-constraint-ii.md"
  "BITCOIN'S_UNFINISHED_CONSTRAINT_PART_III.md|spec/essays/bitcoins-unfinished-constraint-iii.md"
  "GHOST_IN_THE_LEDGER_WHY_AI_HAUNTS_EXECUTION-FIRST_CHAINS.md|spec/essays/ghost-in-the-ledger.md"
  "THE_EMPTY_QUADRANT.md|spec/essays/the-empty-quadrant.md"
  "THE_QUESTION_NO_ONE_BOTHERED_TO_ASK_BITCOIN.MD|spec/essays/the-question-no-one-bothered-to-ask-bitcoin.md"
)

# Architecture docs (from docs/architecture/). Note: upstream has 'boundries' typo; we correct on copy.
ARCH=(
  "docs/architecture/bounded-verification-boundries.md|spec/architecture/bounded-verification-boundaries.md"
  "docs/architecture/architecture-overview.md|spec/architecture/architecture-overview.md"
)

extract_pdf() {
  local src_rel="$1" tgt_rel="$2"
  local src="$SRC/$src_rel" tgt="$ROOT/$tgt_rel"
  if [ ! -f "$src" ]; then
    echo "MISSING (pdf): $src" >&2
    return 1
  fi
  echo "  pdf : $src_rel -> $tgt_rel"
  markitdown "$src" > "$tgt"
}

copy_md() {
  local src_rel="$1" tgt_rel="$2"
  local src="$SRC/$src_rel" tgt="$ROOT/$tgt_rel"
  if [ ! -f "$src" ]; then
    echo "MISSING (md): $src" >&2
    return 1
  fi
  echo "  md  : $src_rel -> $tgt_rel"
  cp "$src" "$tgt"
}

echo "Extracting PDFs..."
for entry in "${PDFS[@]}"; do
  extract_pdf "${entry%%|*}" "${entry##*|}"
done

echo "Copying essays..."
for entry in "${ESSAYS[@]}"; do
  copy_md "${entry%%|*}" "${entry##*|}"
done

echo "Copying architecture docs..."
for entry in "${ARCH[@]}"; do
  copy_md "${entry%%|*}" "${entry##*|}"
done

echo "Done."
