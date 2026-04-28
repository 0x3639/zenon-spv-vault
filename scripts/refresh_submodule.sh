#!/usr/bin/env bash
# Fast-forwards reference/go-zenon to upstream master HEAD and rewrites the
# "**Pinned commit:**" line in reference/CLAUDE.md to match the new commit.
#
# Usage: scripts/refresh_submodule.sh

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SUBMODULE="$ROOT/reference/go-zenon"
PIN_FILE="$ROOT/reference/CLAUDE.md"

if [ ! -d "$SUBMODULE/.git" ] && [ ! -f "$SUBMODULE/.git" ]; then
  echo "Error: $SUBMODULE is not a git submodule (run: git submodule update --init)" >&2
  exit 1
fi

cd "$SUBMODULE"
git fetch origin
git checkout master
git pull --ff-only origin master

NEW_COMMIT="$(git rev-parse HEAD)"
DESCRIBE="$(git describe --tags --always 2>/dev/null || echo "$NEW_COMMIT")"
DATE="$(date +%Y-%m-%d)"

NEW_LINE="**Pinned commit:** \`$NEW_COMMIT\` (master, as of $DATE; tag-context \`$DESCRIBE\`)"

cd "$ROOT"
python3 - "$PIN_FILE" "$NEW_LINE" <<'PY'
import re, sys
path, new_line = sys.argv[1], sys.argv[2]
with open(path) as f:
    s = f.read()
s, n = re.subn(r"\*\*Pinned commit:\*\*[^\n]*", new_line, s, count=1)
if n == 0:
    sys.exit(f"Could not find '**Pinned commit:**' line in {path}")
with open(path, "w") as f:
    f.write(s)
PY

echo "Updated submodule pin to $NEW_COMMIT"
echo "Next: git add reference/go-zenon reference/CLAUDE.md && git commit"
