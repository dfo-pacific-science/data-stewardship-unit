# UAT Follow-up Review (2026-02-17)

This review re-checks recommendations from `UAT_REPORT.md` (PR #145) against the current site and records follow-up changes implemented on 2026-02-17.

## Summary

- **Still relevant and fixed now:** broken nav links, missing Salmon Data Standards landing page, missing FSAR end-to-end workflow, no downloadable SDEP starter package, weak cross-linking to validation guidance.
- **Still relevant and partially improved now:** controlled vocabulary export + related-term interaction.
- **Still relevant but deferred (not medium priority right now):** broader visual/UX enhancements, dark mode, accessibility audit, additional screenshots.

## Recommendation status

| Priority | Recommendation from UAT | Status on 2026-02-17 | Action taken |
|---|---|---|---|
| P0 | Create SDEP example package | ✅ Implemented | Added `reference_info/data_standards/examples/sdep-minimal-example/` + zipped download |
| P0 | Add Getting Started / landing page | ✅ Implemented | Added `reference_info/data_standards/index.qmd`; linked from navbar + sidebar |
| P0 | Link validation tools prominently | ✅ Implemented | Added validation workflow section to `salmon-data-exchange-package.qmd` + linked FSAR workflow |
| P1 | Add FSAR end-to-end workflow guide | ✅ Implemented | Added `how_to_guides/fsar-data-standardization-workflow.qmd` and linked in sidebar |
| P1 | Make related terms clickable | ✅ Implemented | Added click handler to `.related-term-link` to populate search + jump to search panel |
| P1 | Add export functionality for terms | ✅ Implemented | Added CSV and JSON export buttons for visible (current query-matched) terms |
| P1 | Add glossary page | ✅ Implemented | Added `reference_info/glossary.qmd` and sidebar link |

## Notes

- GitHub Actions R runtime issue remains intentionally unaddressed for now; local `corto build` + `corto publish` remains the preferred publication path.
- Medium-priority visual/design enhancements were intentionally deferred.
