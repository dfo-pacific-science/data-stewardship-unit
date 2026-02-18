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
- [ ] Phase 2 (future): simplify top-level nav and reduce repeated deep-link exposure beyond homepage.
- [ ] Phase 3 (future): duplicate-content cleanup and redirect inventory policy.

## Surprises & Discoveries

- The homepage already included dynamic “latest articles” generation with R, which can be reused for the all-articles table.
- `styles/custom.css` existed but was only referenced page-by-page, so homepage modernization required either inline CSS or global stylesheet wiring.
- There is at least one exact duplicate content file: `tutorials/support_controlled_vocabs.qmd` and `documentation_hub/how_to_guides/support_controlled_vocabs.qmd`.
- Full-project render emits pre-existing Quarto warnings about unresolved `.qmd` links from global navigation contexts; these are not introduced by this phase and should be handled in a dedicated nav cleanup phase.

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

## Outcomes & Retrospective

Phase 1 produces a modernized front door and improves discovery without changing core content. It does not yet resolve nav-level duplication or content-duplicate governance. Those are queued for later phases to keep this PR reviewable and low risk.

## Context and Orientation

Key files:

- `_quarto.yml`: global website structure and format defaults.
- `index.qmd`: homepage content and dynamic article listings.
- `styles/custom.css`: custom CSS used by several pages.

Important terms:

- **Quick-start cards**: task-first entry points to common workflows.
- **All-articles table**: complete list of `.qmd` content, converted to links and displayed in a searchable, scrollable table.
- **Phase 1**: homepage UX modernization only.

## Plan of Work

Phase 1 modifies homepage experience only.

1. Update `index.qmd` with:
   - modern hero section and primary calls to action,
   - “start by goal” cards,
   - an all-articles table that users can scroll and scan.
2. Update styling in `styles/custom.css` using homepage-scoped selectors.
3. Register `styles/custom.css` in `_quarto.yml` so styles apply consistently.
4. Render with Quarto and verify `_site/index.html` builds successfully.
5. Commit and open PR with scope and validation notes.

## Concrete Steps

Run from repository root `/Users/alan/code/data-stewardship-unit`:

1. `quarto render index.qmd`
2. `quarto render`
3. `git status --short`
4. `git add _quarto.yml index.qmd styles/custom.css docs/plans/2026-02-18-homepage-ux-modernization-phase1.md`
5. `git commit -m "feat(home): modernize homepage and add all-articles table (phase 1)"`
6. `git push -u origin alan/homepage-ux-phase1`
7. `gh pr create --base main --head alan/homepage-ux-phase1 --title "Homepage UX Phase 1: modern hero + quick paths + all-articles table" --body <body-file>`

Expected results:

- Quarto render succeeds.
- Homepage shows updated hero/cards/table.
- PR is open against `main`.

## Validation and Acceptance

Functional acceptance:

- Open `_site/index.html` and confirm:
  - hero and CTA block render,
  - quick-start cards render and links work,
  - all-articles table appears with all site pages and is scrollable.

Build acceptance:

- `quarto render` completes without errors.

UX acceptance:

- A first-time user can identify where to start within 5 seconds.
- A returning user can locate a specific page via table scan/filter rather than sidebar drilling.

## Idempotence and Recovery

- Re-running `quarto render` is safe and repeatable.
- If visual regressions appear, revert with:
  - `git checkout -- _quarto.yml index.qmd styles/custom.css`
- If PR scope drifts, reset branch to last good commit and re-apply only Phase 1 files.

## Artifacts and Notes

Planned evidence to attach in PR:

- Before/after homepage screenshot snippets.
- `quarto render` success transcript.
- Short list of changed files.

## Interfaces and Dependencies

- Quarto website build pipeline (`quarto render`, `quarto publish`).
- Existing R runtime in homepage for metadata extraction.
- Existing `styles/custom.css` asset for styling.

---

Revision note (2026-02-18): Initial plan created and immediately executed for Phase 1 implementation + PR creation.