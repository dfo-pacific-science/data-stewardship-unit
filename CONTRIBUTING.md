# 🤝 Contributing to the DSU Docs & Tools

Thanks for helping improve the **Data Stewardship Unit (DSU)** site! 🎉  
Whether you're adding a how-to guide, writing up a tutorial, or sharing a helpful tool, your contribution helps make data stewardship easier for everyone in the Pacific Region Science Branch. 🐟🌲

---

## ✍️ How to Write a New Page

If you're already a member of the `dfo-pacific-science` organization, you can edit the repo directly. If not, you can still contribute by creating a pull request (PR) from your forked copy of the repo or creating an issue to request a change.

Want to add a new documentation or tools page? Here's how!

You can open the repo after cloning it in an IDE like RStudio or VSCode depending on your preference. 

### Requirements
1. An IDE ([RStudio](https://posit.co/download/rstudio-desktop/) or [VSCode](https://code.visualstudio.com/Download)
2. [Git SCM](https://git-scm.com/downloads)
3. [Quarto](https://quarto.org/docs/download/index.html)

### 1. Clone the Repo
To open the website locally, clone the repository with git by running `git clone https://github.com/dfo-pacific-science/data-stewardship-unit.git` in terminal in your IDE. 

### 2. Create a new branch
Make a new branch so that you can test things out without messing things up in the main branch. Run `git branch {branchName}` in the terminal in your IDE to make a new branch and `git switch {branchName}` to switch to it. 

### 3. Make a new .qmd file
You can create a new .qmd file in one of the four folders (how_to_guides, reference_info, tutorials, deep_dives) to get it displayed under the navbar menu, which grabs .qmd files automatically. 

### 4. Preview the website 
In terminal, run `quarto preview`. A browser window will pop up with a locally-hosted version of the website. Make sure your changes look good and progress to the next step. Make edits if needed. 

### 5. Render the website
In terminal, run `quarto render`. The complete site will be rendered in the `_site` folder for Github actions to deploy. 

### 6. Push Changes (Add, Commit, Push)
Run `git add {fileName}` for all of the files you want to stage. Make sure to not forget the `_free` folder, which contains all of the information related to R code that runs in some of the .qmd's. 

Run `git commit -m "commit message here"`. 

Run `git push`. If you've never pushed on your current branch, git will prompt you to use something like `git push --set-upstream origin {branchName}`. 

### 7. Create a Pull Request

Create a pull request from your branch and assign a team member to review it. There are protections on the main branch that caution you away from pushing without a review. Once the PR has been merged to main, the Github Action will be automatically triggered. Check the actions tab to see the deployment progress. 

---

## 🚀 Pull Request Tips

### 👯 Best Practices

- Use **feature branches** off the main branch if working on a larger update (e.g. `fix/typo`, `add/new-tool-guide`)
- Otherwise for small updates, commit directly to `main` or create your Pull Request directly from main.
- Group related changes into one PR
- If you're fixing an Issue, mention it in your PR:  
  `Closes #42` will auto-link and close the issue on merge
- Keep commit messages short but clear and in present tense (`"Add how-to for bulk metadata upload"`)

---

## 📝 Working with Issues

Use [GitHub Issues](https://github.com/dfo-pacific-science/data-stewardship-unit/issues) to:
- Request a new topic 📌
- Report a problem 🐛
- Share an idea 💡

We tag and triage regularly — feel free to assign yourself or ask for help!

---

## 🙌 Need Help?

Open an issue, ping someone on the DSU team, or check the [README](./README.md) for more guidance. We're here to help! Thanks again for contributing — every little improvement adds up.
