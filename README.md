# FADS Documentation Hub Site

This website serves as a resource for Fisheries and Oceans Canada employees working in the Pacific Region Science Branch, providing support for their data stewardship and management responsibilities.

## Project Structure

This repository has some the following files and directories of note:

- `_quarto.yml`: The configuration file for the Quarto package.
- `index.qmd`: The home page of the website.
- `images/`: holds logos and images for the site 
- `README.md`: Documentation for the project.
- `CONTRIBUTING.md`: Instructions for contributing to the website. 
- `.github`: Files for Github Actions workflows

## Getting Started

To run the website locally, follow these steps in the terminal:

> Tip: If you use Nix/devenv, run `devenv shell` to get the pinned toolchain (R, Python, Quarto, Node) without extra local installs.

1. Clone the repository with git by running `git clone https://github.com/dfo-pacific-science/data-stewardship-unit.git` in terminal. 
2. Install Quarto: `R -e "install.packages('quarto')"` or follow [Quarto installation instructions](https://quarto.org/docs/get-started/)
3. Install required R packages: `R -e "install.packages(c('reactable', 'readr', 'jsonlite', 'htmltools', 'htmlwidgets', 'yaml'))"`
4. Set up pre-commit hooks (optional but recommended): 
   - Install pre-commit: `pip install pre-commit` or `brew install pre-commit`
   - Install hooks: `pre-commit install`
5. Preview the website by running `quarto preview` or build with `quarto render`
6. To publish the site, run `quarto publish gh-pages --no-browser` from your local environment.

**Note:** The website must be built and published locally. CSV validation happens automatically via pre-commit hooks before commits. The GitHub publish workflow is manual-only (`workflow_dispatch`) to avoid failing push notifications when CI runners lack R.

## Ontology term tables workflow

- Generate term tables in the sibling `dfo-salmon-ontology` repo (uses draft themes; `USE_DRAFT_THEMES=true python scripts/extract-term-tables.py` or `make publish-and-extract` there).
- Sync outputs into this repo from the ontology repo using `scripts/sync_term_tables_to_dsu.sh` (run in the ontology repo, pointing to this repo’s `data/ontology` path).
- This repo does **not** regenerate tables; pre-commit here only validates the CSV/meta files already synced.
- To run validation manually here: `nix run nixpkgs#pre-commit -- run --all-files` inside `devenv shell`.

## Analytics + Most-read setup

This site uses **Plausible** by default because it is privacy-friendly, lightweight, and simple for a static GitHub Pages deployment.

### Analytics instrumentation (build-time)

A Quarto pre-render script generates `_includes/analytics.html` from environment variables:

- `DSU_ANALYTICS_PROVIDER` (default: `plausible`; options: `plausible`, `ga4`, `none`)
- `PLAUSIBLE_DOMAIN` (default: `dfo-pacific-science.github.io`)
- `PLAUSIBLE_SRC` (optional, default: `https://plausible.io/js/script.js`)
- `GA4_MEASUREMENT_ID` (required only when `DSU_ANALYTICS_PROVIDER=ga4`)

Run locally to verify include generation:

```bash
Rscript scripts/setup_analytics.R
```

### Top articles refresh (Plausible API)

`data/top_articles.json` is refreshed by `scripts/refresh_top_articles.py` using Plausible Stats API data.

Required for live API refresh:

- `PLAUSIBLE_API_TOKEN`
- `PLAUSIBLE_SITE_ID` (or fallback: `PLAUSIBLE_DOMAIN`)

Optional:

- `PLAUSIBLE_API_BASE` (default: `https://plausible.io`)
- `TOP_ARTICLES_PERIOD` (default: `7d`)

Run manually:

```bash
python scripts/refresh_top_articles.py
```

If API credentials are missing, the script exits successfully and preserves existing `data/top_articles.json`.

### Daily automation

GitHub Actions workflow `.github/workflows/refresh-top-articles.yml`:

- runs daily + manual dispatch
- refreshes `data/top_articles.json`
- commits changes if data changed

Configure repository secrets/variables:

- **Secrets:** `PLAUSIBLE_API_TOKEN`, `PLAUSIBLE_SITE_ID`
- **Variables (optional):** `PLAUSIBLE_DOMAIN`, `PLAUSIBLE_API_BASE`

## Contributing

If you would like to contribute to this project, please follow the guidelines in [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This project is licensed under the [CC BY 4.0 License](https://creativecommons.org/licenses/by/4.0/).
