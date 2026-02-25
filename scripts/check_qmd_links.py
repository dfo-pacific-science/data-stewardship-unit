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
    "_quarto.yml",
]

MARKDOWN_LINK_RE = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
HTML_HREF_RE = re.compile(r"href\s*=\s*\"([^\"]+)\"", re.I)

SKIP_PREFIXES = ("http://", "https://", "mailto:", "#", "javascript:", "tel:")


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
    # unique
    seen = set()
    out = []
    for p in files:
        if p not in seen:
            out.append(p)
            seen.add(p)
    return out


def normalize_target(raw: str) -> str | None:
    t = raw.strip().strip("<>").strip()
    if not t:
        return None
    if t.startswith(SKIP_PREFIXES):
        return None
    if "%" in t:
        # formatted placeholders in templated strings (e.g., R sprintf)
        return None
    t = t.split("#", 1)[0].split("?", 1)[0].strip()
    if not t:
        return None
    return t


def path_candidates(source: Path, target: str) -> list[Path]:
    candidates = []
    if target.startswith("/"):
        candidates.append(ROOT / target.lstrip("/"))
    else:
        candidates.append((source.parent / target).resolve())

    # Allow .html links to resolve to .qmd source during checks
    if target.endswith(".html"):
        alt = target[:-5] + ".qmd"
        if target.startswith("/"):
            candidates.append(ROOT / alt.lstrip("/"))
        else:
            candidates.append((source.parent / alt).resolve())

    return candidates


def extract_links(path: Path, text: str) -> list[tuple[int, str]]:
    links: list[tuple[int, str]] = []
    for i, line in enumerate(text.splitlines(), start=1):
        for m in MARKDOWN_LINK_RE.finditer(line):
            links.append((i, m.group(1)))
        for m in HTML_HREF_RE.finditer(line):
            links.append((i, m.group(1)))
    return links


def exists_candidate(cands: list[Path]) -> bool:
    for c in cands:
        # normalize candidate within repo root only
        try:
            rel = c.relative_to(ROOT)
        except ValueError:
            continue
        abs_path = ROOT / rel
        if abs_path.exists():
            return True
    return False


def main() -> int:
    failures: list[tuple[Path, int, str]] = []

    for path in gather_files():
        text = path.read_text(encoding="utf-8", errors="ignore")
        for ln, raw in extract_links(path, text):
            target = normalize_target(raw)
            if not target:
                continue
            cands = path_candidates(path, target)
            if not exists_candidate(cands):
                failures.append((path.relative_to(ROOT), ln, raw))

    if failures:
        print("Link check failed. Unresolved internal links:\n")
        for rel, ln, target in failures:
            print(f"- {rel}:{ln} -> {target}")
        return 1

    print("Link check passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
