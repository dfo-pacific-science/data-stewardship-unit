# Minimal salmon data package example

This folder is a minimal, runnable starter for the salmon data package (SDP).

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

## Notes

- Values are illustrative only.
- Update contact, licence, and provenance fields before publication.
- The canonical layout is `metadata/` + `data/` with optional root `datapackage.json`.
