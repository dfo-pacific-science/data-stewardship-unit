# Minimal salmon data package example

This folder is a minimal, runnable starter for the salmon data package (SDP).

For the maintained package creation, review, and validation workflow, prefer the `metasalmon` docs:

- <https://dfo-pacific-science.github.io/metasalmon/articles/metasalmon.html>
- <https://dfo-pacific-science.github.io/metasalmon/articles/data-dictionary-publication.html>

Use this folder when you need a manual starter scaffold or want to inspect the canonical file layout directly.

## Contents

- `datapackage.json` (optional helper file)
- `metadata/dataset.csv`
- `metadata/tables.csv`
- `metadata/column_dictionary.csv`
- `metadata/codes.csv`
- `data/cu_year_index.csv`

## How to use

1. Copy this folder and rename it for your dataset.
2. Replace sample metadata values in the files under `metadata/`.
3. Replace `data/cu_year_index.csv` with your own table(s).
4. Keep column names aligned between your data files and `metadata/column_dictionary.csv`.
5. Validate the package with `metasalmon::validate_salmon_datapackage()` (or your project-owned helper wrapper) before deriving downstream upload files.

## Notes

- Values are illustrative only.
- Update contact, licence, provenance, and semantic IRIs before publication.
- The canonical layout is `metadata/` + `data/` with optional root `datapackage.json`.
- This example passes the current package-structure validator as-is, but it will still warn until you finish the measurement semantics.
