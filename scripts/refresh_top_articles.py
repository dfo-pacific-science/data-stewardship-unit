#!/usr/bin/env python3
"""Fetch top article pages from Plausible and write data/top_articles.json.

Graceful fallback: if required credentials are missing, keep existing file and exit 0.
"""

from __future__ import annotations

import json
import os
import re
import sys
from collections import OrderedDict
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, List
from urllib.parse import parse_qs, unquote, urlparse
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "data" / "top_articles.json"
QMD_DIRS = ["how_to_guides", "reference_info", "tutorials", "deep_dives", "cookbook", "blog"]


def warn(msg: str) -> None:
    print(f"[top-articles] {msg}", file=sys.stderr)


def parse_title_from_qmd(path: Path) -> str:
    try:
        lines = path.read_text(encoding="utf-8").splitlines()
    except Exception:
        return path.stem.replace("-", " ").title()
    if len(lines) > 2 and lines[0].strip() == "---":
        for i in range(1, min(len(lines), 120)):
            line = lines[i].strip()
            if line == "---":
                break
            m = re.match(r"^title:\s*(.+)$", line)
            if m:
                title = m.group(1).strip().strip('"\'')
                return title
    return path.stem.replace("-", " ").title()


def build_article_map() -> Dict[str, Dict[str, str]]:
    article_map: Dict[str, Dict[str, str]] = {}
    for d in QMD_DIRS:
        base = ROOT / d
        if not base.exists():
            continue
        for qmd in sorted(base.rglob("*.qmd")):
            rel_qmd = qmd.relative_to(ROOT).as_posix()
            rel_html = re.sub(r"\\.qmd$", ".html", rel_qmd)
            article_map[f"/{rel_html}"] = {
                "path": rel_html,
                "title": parse_title_from_qmd(qmd),
            }
    return article_map


def canonicalize_page(page: str) -> str | None:
    if not page:
        return None
    p = unquote(page.strip())
    parsed = urlparse(p)
    path = parsed.path if parsed.scheme else p.split("?", 1)[0].split("#", 1)[0]
    if not path:
        return None
    if path == "/":
        return None
    if not path.endswith(".html"):
        if path.endswith("/"):
            path = path + "index.html"
        else:
            path = path + ".html"
    return path if path.startswith("/") else f"/{path}"


def fetch_plausible_top_pages(api_url: str, site_id: str, token: str, period: str, limit: int = 100) -> List[dict]:
    params = (
        f"site_id={site_id}&period={period}&property=event:page&metrics=visitors,pageviews,visit_duration"
        f"&limit={limit}"
    )
    url = f"{api_url.rstrip('/')}/api/v1/stats/breakdown?{params}"
    req = Request(url)
    req.add_header("Authorization", f"Bearer {token}")
    req.add_header("Accept", "application/json")
    with urlopen(req, timeout=30) as resp:
        payload = json.loads(resp.read().decode("utf-8"))
    return payload.get("results", [])


def main() -> int:
    plausible_token = os.getenv("PLAUSIBLE_API_TOKEN", "").strip()
    plausible_site = os.getenv("PLAUSIBLE_SITE_ID", "").strip() or os.getenv("PLAUSIBLE_DOMAIN", "").strip()
    plausible_api = os.getenv("PLAUSIBLE_API_BASE", "https://plausible.io").strip()
    period = os.getenv("TOP_ARTICLES_PERIOD", "7d").strip()

    if not plausible_token or not plausible_site:
        warn("PLAUSIBLE_API_TOKEN or PLAUSIBLE_SITE_ID missing; using existing data/top_articles.json")
        return 0

    article_map = build_article_map()
    if not article_map:
        warn("No article pages discovered; writing empty list")

    try:
        rows = fetch_plausible_top_pages(plausible_api, plausible_site, plausible_token, period)
    except Exception as exc:
        warn(f"Plausible fetch failed: {exc}. Keeping existing data file.")
        return 0

    agg: OrderedDict[str, dict] = OrderedDict()
    for row in rows:
        page = row.get("page") or row.get("event:page") or ""
        cpath = canonicalize_page(str(page))
        if not cpath or cpath not in article_map:
            continue
        current = agg.setdefault(
            cpath,
            {
                "path": article_map[cpath]["path"],
                "title": article_map[cpath]["title"],
                "visitors": 0,
                "pageviews": 0,
                "visit_duration": 0,
            },
        )
        current["visitors"] += int(row.get("visitors", 0) or 0)
        current["pageviews"] += int(row.get("pageviews", 0) or 0)
        current["visit_duration"] += float(row.get("visit_duration", 0) or 0)

    items = sorted(agg.values(), key=lambda x: (-x["pageviews"], -x["visitors"], x["path"]))

    payload = {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "source": {
            "provider": "plausible",
            "site_id": plausible_site,
            "period": period,
            "api_base": plausible_api,
        },
        "items": items,
    }

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"[top-articles] Wrote {OUTPUT} with {len(items)} items")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
