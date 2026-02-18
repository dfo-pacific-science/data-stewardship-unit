# Phase 3: Duplicate-content cleanup and redirect governance

This ExecPlan is a living document. The sections `Progress`, `Surprises & Discoveries`, `Decision Log`, and `Outcomes & Retrospective` must be kept up to date as work proceeds.

This repository follows `/Users/alan/code/hive-brain/PLANS.md` conventions.

## Purpose / Big Picture

After the homepage + navigation improvements, remaining UX friction comes from duplicate routes/content and unclear redirect ownership. This phase establishes a canonical content map and redirect policy so users and maintainers see one clear source of truth for each topic.

## Progress

- [x] (2026-02-18 23:16Z) Created follow-on ExecPlan for post-launch cleanup.
- [ ] Inventory all `.qmd` pages and identify exact duplicates, near-duplicates, and redirect wrappers.
- [ ] Define canonical destinations and deprecation rules for legacy paths.
- [ ] Implement selected cleanup changes (safe, low-risk set first).
- [ ] Re-render + manual publish.

## Surprises & Discoveries

- Exact duplicate confirmed: `tutorials/support_controlled_vocabs.qmd` and `documentation_hub/how_to_guides/support_controlled_vocabs.qmd`.
- Several legacy redirect wrappers remain useful for historical links; deleting them without a policy would be risky.

## Decision Log

- Decision: Run Phase 3 as a separate ExecPlan rather than extending the merged Phase 1/2 plan.
  Rationale: Keeps change scope reviewable and preserves clear closure for shipped work.
  Date/Author: 2026-02-18 / Alan

## Outcomes & Retrospective

Pending execution.

## Context and Orientation

Primary files/areas:

- `_quarto.yml` (navigation + discoverability)
- `documentation_hub/**` (legacy pathways)
- `tutorials/**`, `how_to_guides/**`, `reference_info/**` (canonical content areas)

## Plan of Work

1. Produce a route/content inventory table (path, title, section, type, redirect/non-redirect).
2. Mark each page as one of: canonical, alias redirect, duplicate to remove, or split content.
3. Implement low-risk canonicalization first (exact duplicates), preserving redirects where needed.
4. Validate (`quarto render`) and publish (`quarto publish gh-pages --no-browser`).

## Concrete Steps

1. Generate inventory script output.
2. Commit inventory report (markdown).
3. Apply canonicalization edits.
4. Render and publish.

## Validation and Acceptance

- No broken links after render.
- Duplicate exact-content pages reduced.
- Redirect behavior remains intact for legacy URLs.

## Idempotence and Recovery

- Changes are file-based and reversible via git.
- If any cleanup causes link regressions, revert affected pages and keep redirect wrappers.

## Artifacts and Notes

- To be filled during implementation.

## Interfaces and Dependencies

- Quarto render/publish workflow.
- Existing redirect/meta-refresh pages.
