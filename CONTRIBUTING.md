# 🧠 Contributing to the DSU Website

Welcome contributors to the Data Stewardship Unit website!  
This document contains instructions for working with this [Quarto](https://quarto.org) site and contributing via GitHub.

## ✅ Requirements

- A GitHub account
- Git installed on your machine
- Quarto installed (`install.packages("quarto")` in R or use [Quarto installation guide](https://quarto.org/docs/get-started/))

---

## 🚀 Getting Started

1. **Clone the repository**  
   Open a terminal and run:

   ```bash
   git clone https://github.com/dfo-pacific-science/data-stewardship-unit.git
   cd data-stewardship-unit
   ```

2. **Create a new feature branch off `main`**  
   Use a short, descriptive name for your branch:

   ```bash
   git checkout -b feature/add-about-page
   ```

3. **Install dependencies**  
   In R, run:

   ```r
   install.packages("quarto")
   ```

4. **Make your changes**  
   Edit files, add new content, etc.  
   Preview locally with:

   ```bash
   quarto preview
   ```

---

## 🔁 Contributing Your Work

1. **Push your branch to GitHub**  
   ```bash
   git push -u origin feature/add-about-page
   ```

2. **Open a Pull Request (PR)**  
   - Open a PR against `main`
   - Use a **Draft PR** if your work is not yet ready for review
   - GitHub Actions will automatically generate a **preview deployment** of your changes and post the link as a comment

3. **Review and Collaborate**  
   - Share the preview link with others for feedback
   - Make changes as needed and push more commits — the preview auto-updates

4. **Merge to Main**  
   - Once approved, your PR is merged into `main`
   - This triggers a GitHub Action to **build and publish the site** to GitHub Pages
   - Check deployment status under the **Actions tab** (✅ = successful)

5. **Cleanup**  
   - Delete your branch after merging (GitHub will offer to do this)

---

## 🧪 Local Rendering (optional)

If you want to render locally (not required for PR previews):

```bash
quarto render
```

This generates the site into the `_site/` folder.

---

## 📁 Notes

- **Do not edit or work directly in the `main` branch.**
- You do **not** need to run `quarto publish gh-pages` — deployment is fully handled by GitHub Actions.
- All site deployments are defined in `.github/workflows/publish.yml` (main) and `.github/workflows/preview.yml` (PR previews).

Thanks for helping improve the DSU site!
