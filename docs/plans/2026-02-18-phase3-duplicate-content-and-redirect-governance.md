# Phase 3: Duplicate-content cleanup and redirect governance

This ExecPlan is a living document. The sections `Progress`, `Surprises & Discoveries`, `Decision Log`, and `Outcomes & Retrospective` must be kept up to date as work proceeds.

This repository follows `/Users/alan/code/hive-brain/PLANS.md` conventions.

## Purpose / Big Picture

After the homepage + navigation improvements, remaining UX friction comes from duplicate routes/content and unclear redirect ownership. This phase establishes a canonical content map and redirect policy so users and maintainers see one clear source of truth for each topic.

## Progress

- [x] (2026-02-18 23:16Z) Created follow-on ExecPlan for post-launch cleanup.
- [x] (2026-02-18 23:22Z) Built inventory tool (`scripts/content_route_inventory.py`) and generated `content-routing-inventory-2026-02-18.md`.
- [x] (2026-02-18 23:24Z) Defined canonical/alias governance in `CONTENT_ROUTING_POLICY.md`.
- [x] (2026-02-18 23:29Z) Implemented low-risk cleanup: converted `documentation_hub/how_to_guides/support_controlled_vocabs.qmd` to redirect wrapper and set canonical `redirect_from` on tutorial page.
- [x] (2026-02-18 23:31Z) Updated remaining site-name references aligned to FADS hub naming (`about.qmd`, `tools.qmd`, `reference_info/tools/r_packages.qmd`, `training-resources.qmd`).
- [x] (2026-02-18 23:36Z) Re-rendered full site (`quarto render`) after cleanup; build succeeded.
- [x] (2026-02-18 23:43Z) Opened PR #149 with issue-closing keywords and merged to `main` (merge commit: `dfce23d`).
- [x] (2026-02-18 23:47Z) Published manually with `quarto publish gh-pages --no-browser` (deploy commit: `9b9676d`).

## Surprises & Discoveries

- Exact duplicate confirmed and now resolved: `tutorials/support_controlled_vocabs.qmd` and `documentation_hub/how_to_guides/support_controlled_vocabs.qmd`.
- Several legacy redirect wrappers remain useful for historical links; deleting them without a policy would be risky.
- Inventory after cleanup shows `Exact duplicate pages: 0`, with four explicit redirect wrappers retained for legacy route continuity.

## Decision Log

- Decision: Run Phase 3 as a separate ExecPlan rather than extending the merged Phase 1/2 plan.
  Rationale: Keeps change scope reviewable and preserves clear closure for shipped work.
  Date/Author: 2026-02-18 / Alan

- Decision: Convert duplicate legacy page content into redirect wrappers instead of deleting alias paths.
  Rationale: Preserves backward compatibility for bookmarked/shared URLs while restoring single-source content ownership.
  Date/Author: 2026-02-18 / Alan

- Decision: Include issue-closing keywords in the Phase 3 PR for relevant IA/site-label cleanup issues.
  Rationale: Keeps GitHub workflow tidy by auto-closing stale issues once merged.
  Date/Author: 2026-02-18 / Alan

## Outcomes & Retrospective

Phase 3 completed successfully.

Delivered outcomes:

1. Introduced repeatable route inventory tooling and a generated inventory snapshot.
2. Added explicit canonical/alias routing policy for maintainers.
3. Removed the only exact duplicate-content page by converting the legacy copy to a redirect wrapper.
4. Preserved legacy path continuity while enforcing canonical ownership.
5. Closed relevant IA/site-label issues automatically via PR merge:
   - #136
   - #134
6. Published updated site to GitHub Pages after merge.

What remains out of scope:

- Broader historical issue backlog unrelated to current IA routing cleanup.

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

- PR: https://github.com/dfo-pacific-science/data-stewardship-unit/pull/149
- Merge commit (`main`): `dfce23d`
- Publish commit (`gh-pages`): `9b9676d`
- Closed issues: #136, #134
- Inventory artifact: `content-routing-inventory-2026-02-18.md`
- Policy artifact: `CONTENT_ROUTING_POLICY.md`

## Interfaces and Dependencies

- Quarto render/publish workflow.
- Existing redirect/meta-refresh pages.

---

Revision note (2026-02-18): Plan created for duplicate-content and redirect governance cleanup.
Revision note (2026-02-18, final): Recorded PR merge, issue auto-closure, publish completion, and final outcomes.
