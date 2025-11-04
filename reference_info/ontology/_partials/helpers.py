"""Shared helpers for ontology term table pages."""

from __future__ import annotations

import html
import json
from pathlib import Path
from typing import Dict, Optional, Tuple

import pandas as pd
from IPython.display import HTML, Markdown


def load_dataset(csv_path: Path) -> Tuple[Optional[pd.DataFrame], Dict[str, str]]:
    """Load CSV and metadata if they exist."""
    meta_path = csv_path.with_suffix(".meta.json")
    dataframe: Optional[pd.DataFrame] = None
    if csv_path.exists():
        dataframe = pd.read_csv(csv_path)
    metadata: Dict[str, str] = {}
    if meta_path.exists():
        metadata = json.loads(meta_path.read_text(encoding="utf-8"))
    return dataframe, metadata


def provenance_callout(meta: Dict[str, str]) -> Optional[Markdown]:
    """Return a Quarto callout summarising provenance if metadata present."""
    lines = []
    commit = meta.get("source_version") or meta.get("commit")
    if commit:
        short_commit = commit[:7]
        lines.append(f"- Source commit: `{short_commit}` ({commit})")
    timestamp = meta.get("source_timestamp") or meta.get("generated_at")
    if timestamp:
        lines.append(f"- Extracted: {timestamp}")
    if not lines:
        return None
    body = "\n".join(lines)
    return Markdown(f"::: {{.callout-note}}\n{body}\n:::")


def warning_callout(message: str) -> Markdown:
    """Return a warning callout."""
    return Markdown(f"::: {{.callout-warning}}\n{html.escape(message)}\n:::")


def render_table(df: pd.DataFrame) -> HTML:
    """Render the ontology term table with copy buttons."""
    columns = [
        ("Term Name", "term_name"),
        ("Type", "term_type"),
        ("Controlled Vocabulary", "controlled_vocabulary"),
        ("Definition", "definition"),
        ("Related Terms", "related_terms"),
        ("Canonical URI", "canonical_uri"),
        ("Documentation", "widoco_link"),
    ]

    cleaned = df.copy()
    for _, field in columns:
        if field not in cleaned.columns:
            cleaned[field] = ""
        cleaned[field] = cleaned[field].fillna("")

    header = "".join(f"<th scope='col'>{html.escape(title)}</th>" for title, _ in columns)
    rows_html = []
    for record in cleaned.itertuples(index=False):
        data = {field: getattr(record, field, "") for _, field in columns}
        uri = html.escape(str(data["canonical_uri"]), quote=True) if data["canonical_uri"] else ""
        uri_cell = (
            f"<div class='uri-cell'><code>{uri}</code>"
            f"<button type='button' class='copy-uri' data-uri='{uri}'>Copy</button></div>"
            if uri
            else "<span class='coming-soon'>Unavailable</span>"
        )
        doc_link = html.escape(str(data["widoco_link"]), quote=True)
        if doc_link:
            doc_cell = (
                f"<a href='{doc_link}' target='_blank' rel='noopener'>Widoco</a>"
            )
        else:
            doc_cell = "<span class='coming-soon'>Pending</span>"

        cell_values = [
            html.escape(str(data["term_name"])),
            html.escape(str(data["term_type"])),
            html.escape(str(data["controlled_vocabulary"])),
            html.escape(str(data["definition"])),
            html.escape(str(data["related_terms"])),
            uri_cell,
            doc_cell,
        ]
        row_cells = ''.join(f'<td>{value}</td>' for value in cell_values)
        rows_html.append(f"<tr>{row_cells}</tr>")

    table_html = (
        "<table class='ontology-term-table'>"
        f"<thead><tr>{header}</tr></thead>"
        f"<tbody>{''.join(rows_html)}</tbody>"
        "</table>"
    )
    return HTML(table_html)
