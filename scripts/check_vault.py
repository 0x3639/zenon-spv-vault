#!/usr/bin/env python3
"""Vault invariant checks.

Asserts:
  1. Every required directory exists and has a CLAUDE.md.
  2. Every PDF in the upstream source has a matching .md in spec/
     (when an upstream source path is provided).
  3. reference/go-zenon is a git submodule and the pin in reference/CLAUDE.md
     matches `git submodule status`.
  4. No file in spec/ is zero bytes.

Exit non-zero on failure; print a diff-style summary.

Usage: scripts/check_vault.py [path-to-zenon-developer-commons]
"""
from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys
from pathlib import Path

VAULT = Path(__file__).resolve().parent.parent

REQUIRED_DIRS_WITH_CLAUDE = ["spec", "reference", "external", "notes", "decisions"]

PDF_MAP: dict[str, str] = {
    "1_ZENON_LIGHTPAPER_(CORE_TEAM).pdf": "spec/lightpaper.md",
    "2_ZENON_WHITEPAPER_(CORE_TEAM).pdf": "spec/whitepaper.md",
    "ZENON_GREENPAPER.pdf": "spec/greenpaper.md",
    "ZENON_GREENPAPER_SPV_IMPLEMENTATION_GUIDE.pdf": "spec/spv-implementation-guide.md",
    "ZENON_INDIGOPAPER.pdf": "spec/indigopaper.md",
    "ZENON_PURPLEPAPER.pdf": "spec/purplepaper.md",
    "ZENON_ORANGEPAPER_DRAFT_V1.pdf": "spec/orangepaper.md",
    "ZENON_WHITEPAPER_DECODED:EXPANDED_COMMUNITY_PAPER.pdf": "spec/whitepaper-decoded.md",
    "3_ZENON_GREENPAPER_COVER_LETTER_TO_COMMUNITY.pdf": "spec/cover-letters/greenpaper-to-community.md",
    "4_ZENON_GREENPAPER_COVER_LETTER.pdf": "spec/cover-letters/greenpaper.md",
    "ZENON_INDIGOPAPER_COVER_LETTER.pdf": "spec/cover-letters/indigopaper.md",
    "ZENON_PURPLEPAPER_COVER_LETTER.pdf": "spec/cover-letters/purplepaper.md",
}


def check_dirs_with_claude() -> list[str]:
    failures: list[str] = []
    if not (VAULT / "CLAUDE.md").is_file():
        failures.append("missing CLAUDE.md at vault root")
    for d in REQUIRED_DIRS_WITH_CLAUDE:
        p = VAULT / d
        if not p.is_dir():
            failures.append(f"missing dir: {d}/")
            continue
        if not (p / "CLAUDE.md").is_file():
            failures.append(f"missing CLAUDE.md in: {d}/")
    return failures


def check_pdf_targets(src_path: str | None) -> list[str]:
    if not src_path:
        return ["[skipped: no upstream source path provided]"]
    failures: list[str] = []
    src = Path(src_path)
    if not src.is_dir():
        return [f"source dir not found: {src}"]
    for pdf, tgt in PDF_MAP.items():
        if not (src / pdf).is_file():
            failures.append(f"upstream PDF missing: {pdf}")
        if not (VAULT / tgt).is_file():
            failures.append(f"vault target missing: {tgt}")
    return failures


def check_submodule_pin() -> list[str]:
    try:
        out = subprocess.check_output(
            ["git", "-C", str(VAULT), "submodule", "status"], text=True
        )
    except subprocess.CalledProcessError as e:
        return [f"git submodule status failed: {e}"]

    actual: str | None = None
    for line in out.splitlines():
        m = re.match(r"[+\- ]?([0-9a-f]{40})\s+reference/go-zenon", line.strip())
        if m:
            actual = m.group(1)
            break
    if actual is None:
        return ["could not parse submodule status for reference/go-zenon"]

    md = (VAULT / "reference" / "CLAUDE.md").read_text()
    m2 = re.search(r"\*\*Pinned commit:\*\*\s*`([0-9a-f]{40})`", md)
    if not m2:
        return ["reference/CLAUDE.md does not contain a 40-char pinned commit hash"]
    pinned = m2.group(1)
    if actual != pinned:
        return [
            f"submodule pin mismatch: actual={actual} pinned-in-CLAUDE.md={pinned}"
        ]
    return []


def check_no_empty_in_spec() -> list[str]:
    failures: list[str] = []
    spec = VAULT / "spec"
    if not spec.is_dir():
        return ["spec/ directory missing"]
    for p in spec.rglob("*.md"):
        if p.stat().st_size == 0:
            failures.append(f"zero-byte spec file: {p.relative_to(VAULT)}")
    return failures


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument(
        "src",
        nargs="?",
        default=os.environ.get("SRC", ""),
        help="path to upstream zenon-developer-commons clone (optional)",
    )
    args = ap.parse_args()
    src = args.src or None

    sections = [
        ("directories with CLAUDE.md", check_dirs_with_claude()),
        ("PDF source/target mapping", check_pdf_targets(src)),
        ("submodule pin", check_submodule_pin()),
        ("no zero-byte files in spec/", check_no_empty_in_spec()),
    ]

    total = 0
    for label, fs in sections:
        if fs and fs != ["[skipped: no upstream source path provided]"]:
            print(f"FAIL : {label}")
            for f in fs:
                print(f"   - {f}")
            total += len(fs)
        elif fs == ["[skipped: no upstream source path provided]"]:
            print(f"SKIP : {label}  (provide upstream src path to enable)")
        else:
            print(f"OK   : {label}")

    if total:
        print(f"\n{total} failure(s)")
        return 1
    print("\nAll checks passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
