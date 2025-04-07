# 🔁 Git Branching Policy

We use a **feature-branch workflow off `main`** to keep things simple and support live site previews on pull requests.

### 📌 Main Branches

| Branch | Purpose           | Notes                         |
|--------|-------------------|-------------------------------|
| `main` | Production branch | Auto-deploys to GitHub Pages  |

### 🌿 Feature Branches

- Start a new branch from `main` using the naming pattern:  
  `feature/your-topic` or `bugfix/fix-thing`
- Open a pull request targeting `main` as early as possible
- The site will auto-build and deploy a preview of your changes
- Where you think some review would be useful, request a review of your PR
- Once approved, your branch is merged into `main`

### 🔀 Pull Requests

- Always open a PR for review and preview.
- Use **draft PRs** if your work isn’t ready for review but you want a preview.
- GitHub Actions will post a comment with a live preview URL.
- Try not to commit directly to `main` unless making minor updates not requiring review.

### 🧼 Cleanup

- Preview branches are auto-generated (`preview/pr-##`) — don’t use them for development.
- You can delete your feature branch after merging your PR.

