"""Validate ontology term table artifacts prior to rendering the site."""

from __future__ import annotations

import csv
import json
import sys
from pathlib import Path
from typing import Dict, List

EXPECTED_FILES: Dict[str, Dict[str, str]] = {
    "stock-assessment-terms": {
        "csv": "data/ontology/release/artifacts/term-tables/stock-assessment-terms.csv",
    },
    "genetics-terms": {
        "csv": "data/ontology/release/artifacts/term-tables/genetics-terms.csv",
    },
    "legislation-terms": {
        "csv": "data/ontology/release/artifacts/term-tables/legislation-terms.csv",
    },
    "benchmarks-terms": {
        "csv": "data/ontology/release/artifacts/term-tables/benchmarks-terms.csv",
    },
    "temporal-terms": {
        "csv": "data/ontology/release/artifacts/term-tables/temporal-terms.csv",
    },
}

REQUIRED_COLUMNS: List[str] = [
    "term_name",
    "term_type",
    "controlled_vocabulary",
    "definition",
    "related_terms",
    "canonical_uri",
    "widoco_link",
    "source_version",
    "source_timestamp",
    "query_checksum",
]


def validate_csv(path: Path) -> List[str]:
    """Check CSV header and canonical URI coverage."""
    errors: List[str] = []
    if not path.exists():
        errors.append(f"Missing CSV file: {path}")
        return errors

    with path.open("r", encoding="utf-8", newline="") as handle:
        reader = csv.DictReader(handle)
        missing_columns = [col for col in REQUIRED_COLUMNS if col not in reader.fieldnames]
        if missing_columns:
            errors.append(
                f"{path}: missing required columns {', '.join(missing_columns)}"
            )
            return errors

        row_count = 0
        missing_uri_rows = 0
        for row in reader:
            row_count += 1
            if not row.get("canonical_uri"):
                missing_uri_rows += 1
        if row_count == 0:
            errors.append(f"{path}: file is empty")
        if missing_uri_rows:
            errors.append(f"{path}: {missing_uri_rows} rows missing canonical_uri")
    return errors


def validate_meta(csv_path: Path) -> List[str]:
    """Ensure metadata JSON exists and contains key fields."""
    errors: List[str] = []
    meta_path = csv_path.with_suffix(".meta.json")
    if not meta_path.exists():
        errors.append(f"Missing metadata file alongside {csv_path.name}")
        return errors

    try:
        payload = json.loads(meta_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        errors.append(f"{meta_path}: invalid JSON ({exc})")
        return errors

    for field in ("source_version", "source_timestamp", "query_checksum"):
        if not payload.get(field):
            errors.append(f"{meta_path}: missing {field}")
    return errors


def main() -> int:
    all_errors: List[str] = []
    for theme, files in EXPECTED_FILES.items():
        csv_path = Path(files["csv"])
        all_errors.extend(validate_csv(csv_path))
        all_errors.extend(validate_meta(csv_path))

    if all_errors:
        print("Validation failed:")
        for message in all_errors:
            print(f" - {message}")
        return 1

    print("Ontology term tables validated successfully.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
