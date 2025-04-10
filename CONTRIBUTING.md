# 🤝 Contributing to the DSU Docs & Tools

Thanks for helping improve the **Data Stewardship Unit (DSU)** site! 🎉  
Whether you're adding a how-to guide, writing up a tutorial, or sharing a helpful tool, your contribution helps make data stewardship easier for everyone in the Pacific Region Science Branch. 🐟🌲

---

## ✍️ How to Write a New Page

If you're already a member of the `dfo-pacific-science` organization, you can edit the repo directly. If not, you can still contribute by creating a pull request (PR) from your forked copy of the repo or creating an issue to request a change.

Want to add a new documentation or tools page? Here's the easy way — no terminal required!

### 🧑‍💻 Option A: Use GitHub's Web Interface

1. Navigate to the appropriate folder from https://github.com/dfo-pacific-science/data-stewardship-unit/tree/main:
   - For documentation: `docs/`
   - For tools: `tools/`

2. Click **`Add file` > `Create new file`**

3. Name your file something like `my-awesome-guide.qmd  
   (`.qmd` file extension = [Quarto](https://quarto.org) markdown file!)

4. Paste in your content (use [Markdown](https://www.markdownguide.org/cheat-sheet/) formatting!)

5. Once your ready to save, scroll down and give your change a **brief commit message**, and choose:
   - Commit directly to `main` if it’s a tiny fix (spelling, typo, etc.)
   - **Or**, select **"Create a new branch"** if it’s a new page or major edit.

6. Hit **"Propose changes"** — GitHub will create a **pull request (PR)** for you automatically which DSU staff will review! 🚀

---

### 💻 Option B: Use GitHub Codespaces (Recommended for Full Previews of Rendered Content)

Codespaces gives you a ready-to-go dev environment right in your browser — no setup required!

1. Go to the repo homepage  
2. Click the green **`<> Code`** button → Select **`Codespaces`** → Click **`+ Create codespace on main`**  
   🧙‍♀️ Magic! A fully configured VS Code environment opens in your browser.

3. Navigate to the `docs/` or `tools/` folder  
4. Create a new `.qmd` file and write your content  
5. Open a terminal (in Codespaces: `Terminal > New Terminal`) and run:

   ```bash
   quarto preview
   ```

   This launches a local preview so you can **see your page rendered live** in a browser tab! 🌐✨

6. When you’re ready, commit your changes:
   - Use **Source Control** (sidebar tab) to write a commit message
   - Either push to a new branch and open a PR, or push to `main` if it's a tiny fix

✅ **Bonus**: You’re working in the exact same environment the GitHub Action uses to render your PR — what you see is what will ship.

📝 **Note**: Using Codespaces uses your personal credits on GitHub, but it’s free for public repositories up to 120 minutes a month. If you run out of credits, you can still use the web interface to create PRs.

---

## 🚀 Pull Request Tips

### ✨ What Happens When You Open a PR?

Thanks to our [GitHub Actions](https://github.com/dfo-pacific-science/data-stewardship-unit/tree/main/.github/workflows), every pull request gets a **live preview** of the updated site!  
You’ll get a comment like this automatically on your PR:

> 🚀 Preview your site here:  
> 👉 https://**your-username**.github.io/**repo-name**/preview/pr-123/

This lets you:
- ✅ Check formatting
- 🧪 Test links and images
- 👀 Review the full look before merging

### 👯 Best Practices

- Use **feature branches** off the main branch if working on a larger update (e.g. `fix/typo`, `add/new-tool-guide`)
- Otherwise for small updates, commit directly to `main` or create your Pull Request directly from main.
- Group related changes into one PR
- If you're fixing an Issue, mention it in your PR:  
  `Closes #42` will auto-link and close the issue on merge
- Keep commit messages short but clear (`"Add how-to for bulk metadata upload"`)

---

## 📝 Working with Issues

Use [GitHub Issues](https://github.com/dfo-pacific-science/data-stewardship-unit/issues) to:
- Request a new topic 📌
- Report a problem 🐛
- Share an idea 💡

We tag and triage regularly — feel free to assign yourself or ask for help!

---

## 🧪 Preview Like a Pro

Here’s how our **Quarto PR Preview GitHub Action** works:

1. Every time you open or update a PR to `main`, it renders the site with your changes.
2. It creates a special branch like `preview/pr-123` with the rendered site.
3. A bot drops a link on your PR so you can view the live preview in your browser.
4. Once merged, your changes go live on the main site!

---

## 🙌 Need Help?

Open an issue, ping someone on the DSU team, or check the [README](./README.md) for more guidance. We're here to help!

Thanks again for contributing — every little improvement adds up. 🧼📈  
Let’s make our data stewardship tools and documentation ✨awesome✨ together.
