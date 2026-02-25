#!/usr/bin/env python3
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]

TARGET_DIRS = [
    "how_to_guides",
    "reference_info",
    "tutorials",
    "deep_dives",
    "cookbook",
    "blog",
]

TARGET_FILES = [
    "index.qmd",
    "fads-portfolio.qmd",
    "tools.qmd",
    "training-resources.qmd",
    "about.qmd",
]

FORBIDDEN_PATTERNS = [
    (re.compile(r"https?://w3id\.org/dfo/spsi", re.I), "Legacy SPSI namespace"),
    (re.compile(r"https?://purl\.dataone\.org/odo/SALMON", re.I), "Legacy DataONE SALMON URI"),
    (re.compile(r"\bNCEAS\s+Salmon\s+Ontology\b", re.I), "Legacy NCEAS ontology framing"),
    (re.compile(r"Term\s+Dictionary\s*\+\s*Data\s+Package\s*\+\s*Salmon\s+GPT", re.I), "Retired page label"),
    (re.compile(r"\bunder\s+construction\b", re.I), "Placeholder phrase"),
]


def gather_files() -> list[Path]:
    files: list[Path] = []
    for d in TARGET_DIRS:
        base = ROOT / d
        if base.exists():
            files.extend(sorted(base.rglob("*.qmd")))
    for f in TARGET_FILES:
        p = ROOT / f
        if p.exists():
            files.append(p)
    # unique while preserving order
    seen = set()
    out = []
    for p in files:
        if p not in seen:
            out.append(p)
            seen.add(p)
    return out


def main() -> int:
    failures = []
    for path in gather_files():
        text = path.read_text(encoding="utf-8", errors="ignore")
        lines = text.splitlines()
        for i, line in enumerate(lines, start=1):
            for pattern, reason in FORBIDDEN_PATTERNS:
                if pattern.search(line):
                    failures.append((path.relative_to(ROOT), i, reason, line.strip()))

    if failures:
        print("Pattern check failed. Found blocked legacy patterns:\n")
        for rel, ln, reason, snippet in failures:
            print(f"- {rel}:{ln} [{reason}] {snippet}")
        return 1

    print("Pattern check passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
