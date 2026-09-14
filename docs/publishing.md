# Publishing to GitHub

Suggested repository name:

```text
agentic-engineering-harness
```

With GitHub CLI installed:

```powershell
cd path\to\agentic-engineering-harness
git init
git add .
git commit -m "Initial validated agentic engineering harness"
git branch -M main
gh repo create agentic-engineering-harness --public --source=. --remote=origin --push
```

Then enable GitHub Pages from the repository root (`main` branch / root) so `index.html` becomes the public article.

Before pushing:
- review `LICENSE`
- confirm no API keys or local memory DBs exist
- optionally change repository owner/name in README
- pin version-specific implementation notes
