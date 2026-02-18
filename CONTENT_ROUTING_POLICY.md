# Content Routing Policy (FADS Open Science Hub)

This policy defines how pages in this repository should be structured and routed so users have a single canonical destination per topic while legacy URLs keep working.

## Routing model

### Canonical page
A canonical page is the single source of truth for a topic.

- Canonical pages live in one of:
  - `how_to_guides/`
  - `reference_info/`
  - `tutorials/`
  - `deep_dives/`
  - `blog/`
  - `cookbook/`
- Canonical pages should be the only pages with full content for that topic.

### Legacy alias page
A legacy alias page exists only to preserve old links.

- Legacy aliases should live in `documentation_hub/` (or another explicit legacy location).
- Legacy aliases should use redirect-only content (meta refresh + canonical link).
- Legacy aliases must not carry full duplicate instructional content.

## Duplicate-content rules

1. Do not maintain two full-content `.qmd` pages with the same topic.
2. If a duplicate is discovered:
   - keep the canonical page,
   - convert the other page to a redirect-only alias,
   - update this policy/report artifacts as needed.
3. Sidebars/nav should always link to canonical pages.

## Redirect guidance

- Prefer lightweight static redirects for legacy paths.
- Preserve legacy URLs when they may be bookmarked/shared externally.
- Remove aliases only when usage is known to be negligible and links are cleaned up.

## Change checklist

For route/content changes:

1. Run inventory: `python3 scripts/content_route_inventory.py --root . --out content-routing-inventory-YYYY-MM-DD.md`
2. Confirm no new exact duplicates.
3. Confirm nav/sidebar links point to canonical paths.
4. Render site: `quarto render`
5. Publish manually: `quarto publish gh-pages --no-browser`

## Ownership

- Primary owner: maintainers of `data-stewardship-unit` documentation IA.
- Policy updates should be versioned in git and referenced in related PRs.
