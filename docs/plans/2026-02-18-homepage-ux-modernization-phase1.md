# Modernize homepage UX and establish clearer browse paths

This ExecPlan is a living document. The sections `Progress`, `Surprises & Discoveries`, `Decision Log`, and `Outcomes & Retrospective` must be kept up to date as work proceeds.

This repository contains `PLANS.md` at the repository root in `/Users/alan/code/hive-brain/PLANS.md`. This ExecPlan is maintained in accordance with that document.

## Purpose / Big Picture

The current site has strong content but the front page feels static and index-like. After this change, users should land on a more modern homepage that immediately answers: “what can I do here?” and provides a full, scrollable article catalog they can search and sort. This should reduce navigation friction and make discovery easier for first-time and returning users.

## Progress

- [x] (2026-02-18 20:35Z) Created ExecPlan and defined phased scope.
- [x] (2026-02-18 20:52Z) Implemented Phase 1 homepage redesign in `index.qmd` with modern hero, quick-start cards, and scrollable all-articles table.
- [x] (2026-02-18 20:55Z) Added homepage-specific modern styles in `styles/custom.css` and wired global stylesheet in `_quarto.yml`.
- [x] (2026-02-18 21:07Z) Rendered site locally (`quarto render index.qmd`, `quarto render`) and validated output generation.
- [x] (2026-02-18 21:10Z) Opened PR with Phase 1 changes and summary: https://github.com/dfo-pacific-science/data-stewardship-unit/pull/148
- [x] (2026-02-18 22:10Z) Added cookbook-inspired homepage polish pass (featured pathway shelf + type-chip catalog filtering) to active PR branch.
- [x] (2026-02-18 22:33Z) Merged open PR branch `alan/nav-fixes-semantic-uat` (#147) into `alan/homepage-ux-phase1` and validated integrated content paths.
- [x] (2026-02-18 22:34Z) Merged open PR branch `claude/salmon-data-standardization-N8GOM` (#145) into `alan/homepage-ux-phase1`.
- [x] (2026-02-18 22:39Z) Re-rendered full site (`quarto render`) after branch integrations; build succeeded.
- [x] (2026-02-18 22:58Z) Closed superseded PRs #145, #146, and #147 with references to consolidated integration in #148.
- [x] (2026-02-18 23:08Z) Executed next stage: simplified top-level navbar and reduced repeated deep-link exposure in `_quarto.yml`.
- [x] (2026-02-18 23:12Z) Re-rendered full site (`quarto render`) after nav simplification; build succeeded without prior unresolved nav-link warnings.
- [x] (2026-02-18 22:49Z) Merged consolidated PR #148 to `main` (merge commit: `871eab8`).
- [x] (2026-02-18 22:53Z) Ran `quarto publish gh-pages --no-browser` (deploy commit: `edab79f`; published to GitHub Pages).
- [x] (2026-02-18 23:00Z) Closed this ExecPlan as complete for Phase 1+2 scope. Deferred Phase 3 (duplicate/redirect governance) to a follow-on plan.

## Surprises & Discoveries

- The homepage already included dynamic “latest articles” generation with R, which can be reused for the all-articles table.
- `styles/custom.css` existed but was only referenced page-by-page, so homepage modernization required either inline CSS or global stylesheet wiring.
- There is at least one exact duplicate content file: `tutorials/support_controlled_vocabs.qmd` and `documentation_hub/how_to_guides/support_controlled_vocabs.qmd`.
- Before integrating #147, full-project render emitted unresolved `.qmd` nav-link warnings from global navigation contexts.
- After integrating #147, those unresolved nav-link warnings disappeared in local render, confirming the nav/content additions closed those gaps.

## Decision Log

- Decision: Deliver Phase 1 as homepage-only modernization before broader IA refactors.
  Rationale: Highest visible UX impact with lowest risk; aligns with request to execute first phase as PR.
  Date/Author: 2026-02-18 / Alan

- Decision: Add global stylesheet via `_quarto.yml` and scope new visual rules with homepage classes.
  Rationale: Keeps implementation maintainable while minimizing unintended side effects on other pages.
  Date/Author: 2026-02-18 / Alan

- Decision: Implement a client-side scrollable article table rendered from current `.qmd` metadata.
  Rationale: Meets explicit requirement for a complete article table without introducing new backend dependencies.
  Date/Author: 2026-02-18 / Alan

- Decision: Integrate open PR work (#147 and #145) directly into the active homepage branch instead of leaving parallel open review tracks.
  Rationale: User explicitly requested integration; this consolidates review into one branch/PR and removes overlap between homepage UX changes and nav/UAT fixes.
  Date/Author: 2026-02-18 / Alan

- Decision: Close PRs #145/#146/#147 as superseded once their contents were confirmed in #148.
  Rationale: Reduces reviewer confusion and keeps one authoritative merge surface.
  Date/Author: 2026-02-18 / Alan

- Decision: Execute Phase 2 as navbar simplification in `_quarto.yml` (leaner top-level IA, push deep links to sidebar/content pages).
  Rationale: Aligns with UX goal to reduce cognitive load and better match modern cookbook-style top-level navigation.
  Date/Author: 2026-02-18 / Alan

## Outcomes & Retrospective

Delivered outcomes:

1. Homepage modernization (hero, quick paths, featured pathways, article catalog with filtering).
2. Integrated nav/UAT/documentation work from prior PRs into one merge surface.
3. Top-level navbar simplification to reduce cognitive load.
4. Consolidated merge to `main` via PR #148 and successful manual publish to GitHub Pages.

Net effect: clearer entry points, improved discovery, and a single coherent information flow from homepage to standards/workflow content.

Deferred scope: duplicate-route/content cleanup and explicit redirect governance. These are intentionally moved to a follow-on ExecPlan so this plan can be closed cleanly.

## Context and Orientation

Key files:

- `_quarto.yml`: global website structure and format defaults.
- `index.qmd`: homepage content and dynamic article listings.
- `styles/custom.css`: custom CSS used by several pages.

Important terms:

- **Quick-start cards**: task-first entry points to common workflows.
- **All-articles table**: complete list of `.qmd` content, converted to links and displayed in a searchable, scrollable table.
- **Phase 1 + 2 scope**: homepage modernization plus top-level navigation simplification.

## Plan of Work

Executed in three stages:

1. **Phase 1 (Homepage modernization):**
   - Update `index.qmd` with modern hero, task cards, featured pathways, and a full article catalog.
   - Update `styles/custom.css` with homepage-scoped visual system.
   - Register global CSS in `_quarto.yml`.
2. **Integration stage:**
   - Merge open related PR branches (#147, #145; #146 superseded by #147 content) into one consolidated branch/PR.
   - Re-render entire site and verify coherence.
3. **Phase 2 (Navigation simplification):**
   - Simplify top-level navbar in `_quarto.yml` and reduce deep-link duplication at the top level.
   - Re-render and publish manually (`quarto publish`) due CI publishing issues.

## Concrete Steps

Executed from repository root `/Users/alan/code/data-stewardship-unit`:

1. Implement homepage and style changes (`index.qmd`, `styles/custom.css`, `_quarto.yml`).
2. Validate with:
   - `quarto render index.qmd`
   - `quarto render`
3. Create and iterate PR #148 on branch `alan/homepage-ux-phase1`.
4. Integrate related branches:
   - `git merge --no-ff origin/alan/nav-fixes-semantic-uat`
   - `git merge --no-ff origin/claude/salmon-data-standardization-N8GOM`
5. Close superseded PRs (#145, #146, #147).
6. Merge consolidated PR #148 to `main`.
7. Publish site manually:
   - `quarto publish gh-pages --no-browser`

Observed results:

- Full site render succeeded repeatedly after each stage.
- Consolidated PR merged to `main`.
- Site published successfully to GitHub Pages.

## Validation and Acceptance

Functional acceptance (achieved):

- `_site/index.html` shows modern hero, quick paths, featured pathways, and full article catalog with search/type filtering.
- Navigation reflects simplified top-level IA with clearer primary paths.

Build acceptance (achieved):

- `quarto render` completed successfully after phase 1, after integration stage, and after phase 2 nav changes.

Deployment acceptance (achieved):

- `quarto publish gh-pages --no-browser` succeeded and published to:
  - https://dfo-pacific-science.github.io/data-stewardship-unit/

UX acceptance (qualitative):

- First-visit orientation improved by stronger homepage hierarchy and explicit pathways.
- Content discovery improved through the all-articles browse table and reduced top-nav clutter.

## Idempotence and Recovery

- Re-running `quarto render` is safe and repeatable.
- If visual regressions appear, revert with:
  - `git checkout -- _quarto.yml index.qmd styles/custom.css`
- If PR scope drifts, reset branch to last good commit and re-apply only Phase 1 files.

## Artifacts and Notes

Execution evidence:

- Consolidated PR: https://github.com/dfo-pacific-science/data-stewardship-unit/pull/148
- Merge commit to `main`: `871eab8`
- Publish commit to `gh-pages`: `edab79f`
- Superseded PRs closed: #145, #146, #147
- Successful `quarto render` and `quarto publish` transcripts captured in session logs.

## Interfaces and Dependencies

- Quarto website build pipeline (`quarto render`, `quarto publish`).
- Existing R runtime in homepage for metadata extraction.
- Existing `styles/custom.css` asset for styling.

---

Revision note (2026-02-18): Initial plan created and immediately executed for Phase 1 implementation + PR creation.
Revision note (2026-02-18, later): Updated to reflect integration of open PR branches #147 and #145 into the active homepage PR branch.
Revision note (2026-02-18, latest): Recorded superseded PR closure and Phase 2 navbar simplification execution.
Revision note (2026-02-18, final): Marked plan complete after merge-to-main and manual `quarto publish` deployment.