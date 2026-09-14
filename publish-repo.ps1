$ErrorActionPreference = "Stop"

$repoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoDir

gh auth status

if (-not (Test-Path ".git")) {
    git init
    git branch -M main
}

git add .
git diff --cached --check

if (-not (git rev-parse --verify HEAD 2>$null)) {
    git commit -m "Initial validated agentic engineering harness"
} elseif (git diff --cached --quiet) {
    Write-Host "No new changes to commit."
} else {
    git commit -m "Update agentic engineering harness"
}

$exists = $false
gh repo view SergioMazariego/agentic-engineering-harness *> $null
if ($LASTEXITCODE -eq 0) { $exists = $true }

if (-not $exists) {
    gh repo create SergioMazariego/agentic-engineering-harness `
        --public `
        --source=. `
        --remote=origin `
        --push `
        --description "Vendor-agnostic experiments and a reproducible DSH reference implementation for hierarchical agentic engineering."
} else {
    if (-not (git remote get-url origin 2>$null)) {
        git remote add origin https://github.com/SergioMazariego/agentic-engineering-harness.git
    }
    git push -u origin main
}

Write-Host ""
Write-Host "Repository: https://github.com/SergioMazariego/agentic-engineering-harness"
