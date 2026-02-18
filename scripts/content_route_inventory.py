#!/usr/bin/env python3
"""Generate a route/content inventory for Quarto pages.

Outputs a markdown report to stdout by default.
"""

from __future__ import annotations

import argparse
import hashlib
import re
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path


EXCLUDE_DIRS = {"_site", "_freeze", ".quarto", ".git", ".venv", ".devenv"}


@dataclass
class Page:
    path: Path
    rel: str
    title: str
    kind: str
    has_meta_refresh: bool
    has_redirect_from: bool
    sha: str
    canonical_target: str = ""
    notes: str = ""


def extract_frontmatter(text: str) -> str:
    if not text.startswith("---\n"):
        return ""
    m = re.search(r"\n---\n", text[4:])
    if not m:
        return ""
    end = 4 + m.start()
    return text[4:end]


def extract_title(text: str, path: Path) -> str:
    fm = extract_frontmatter(text)
    if fm:
        m = re.search(r"^title:\s*[\"']?(.+?)[\"']?\s*$", fm, re.M)
        if m:
            return m.group(1).strip()
    h1 = re.search(r"^#\s+(.+)$", text, re.M)
    if h1:
        return h1.group(1).strip()
    return path.stem.replace("-", " ").replace("_", " ").title()


def page_kind(rel: str) -> str:
    if rel.startswith("how_to_guides/"):
        return "How-to"
    if rel.startswith("reference_info/"):
        return "Reference"
    if rel.startswith("tutorials/"):
        return "Tutorial"
    if rel.startswith("deep_dives/"):
        return "Deep dive"
    if rel.startswith("blog/"):
        return "News"
    if rel.startswith("cookbook/"):
        return "Cookbook"
    if rel.startswith("documentation_hub/"):
        return "Legacy alias"
    return "Other"


def find_qmd_files(root: Path) -> list[Path]:
    files: list[Path] = []
    for p in root.rglob("*.qmd"):
        if any(part in EXCLUDE_DIRS for part in p.parts):
            continue
        files.append(p)
    return sorted(files)


def generate_inventory(root: Path) -> list[Page]:
    files = find_qmd_files(root)
    pages: list[Page] = []

    for path in files:
        text = path.read_text(encoding="utf-8", errors="ignore")
        rel = str(path.relative_to(root))
        fm = extract_frontmatter(text)
        has_meta_refresh = 'http-equiv="refresh"' in text
        has_redirect_from = "redirect_from:" in fm
        sha = hashlib.sha256(text.encode("utf-8", errors="ignore")).hexdigest()
        pages.append(
            Page(
                path=path,
                rel=rel,
                title=extract_title(text, path),
                kind=page_kind(rel),
                has_meta_refresh=has_meta_refresh,
                has_redirect_from=has_redirect_from,
                sha=sha,
            )
        )

    by_sha: dict[str, list[Page]] = defaultdict(list)
    for page in pages:
        by_sha[page.sha].append(page)

    for group in by_sha.values():
        if len(group) <= 1:
            continue
        canonical = sorted(group, key=lambda p: p.rel)[0]
        for page in group:
            if page is canonical:
                page.notes = "Canonical among exact duplicates"
            else:
                page.notes = "Exact duplicate"
                page.canonical_target = canonical.rel

    return pages


def to_markdown(pages: list[Page]) -> str:
    total = len(pages)
    redirects = sum(1 for p in pages if p.has_meta_refresh)
    redirect_from = sum(1 for p in pages if p.has_redirect_from)
    exact_dupes = sum(1 for p in pages if p.canonical_target)

    lines: list[str] = []
    lines.append("# Content Routing Inventory (Generated)")
    lines.append("")
    lines.append(f"- Total `.qmd` pages: **{total}**")
    lines.append(f"- Meta-refresh redirect wrappers: **{redirects}**")
    lines.append(f"- Pages with `redirect_from`: **{redirect_from}**")
    lines.append(f"- Exact duplicate pages: **{exact_dupes}**")
    lines.append("")
    lines.append("| Path | Title | Kind | Redirect Wrapper | Redirect From | Canonical Target | Notes |")
    lines.append("|---|---|---|---:|---:|---|---|")

    for p in sorted(pages, key=lambda x: x.rel):
        lines.append(
            "| {path} | {title} | {kind} | {refresh} | {redirect_from} | {target} | {notes} |".format(
                path=p.rel,
                title=p.title.replace("|", "\\|"),
                kind=p.kind,
                refresh="yes" if p.has_meta_refresh else "no",
                redirect_from="yes" if p.has_redirect_from else "no",
                target=p.canonical_target,
                notes=p.notes,
            )
        )

    return "\n".join(lines) + "\n"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", default=".", help="Repository root")
    parser.add_argument("--out", default="", help="Optional output markdown path")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    pages = generate_inventory(root)
    md = to_markdown(pages)

    if args.out:
        out = Path(args.out)
        out.write_text(md, encoding="utf-8")
    else:
        print(md)


if __name__ == "__main__":
    main()
