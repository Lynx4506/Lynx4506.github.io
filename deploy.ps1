# Deploy Lynx personal site to GitHub Pages
#
# Prerequisites:
#   - Git and GitHub CLI installed: https://cli.github.com/
#   - Authenticated: gh auth login
#
# Usage (PowerShell):
#   cd C:\Users\LYNX\lynx.github.io
#   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#   .\deploy.ps1
#
# After the first push, enable Pages in the repo:
#   GitHub -> Settings -> Pages -> Deploy from branch -> main -> / (root)
#
# After deploy (your account): https://Lynx4506.github.io

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

Write-Host "Detecting GitHub username..."
$username = (gh api user --jq .login).Trim()
if (-not $username) {
  throw "Could not detect GitHub username. Run 'gh auth login' first."
}

$repoName = "$username.github.io"
$repoSlug = "$username/$repoName"
Write-Host "Target repository: $repoSlug"

if (-not (Test-Path ".git")) {
  git init
  git branch -M main
}

git remote get-url origin *> $null
if ($LASTEXITCODE -ne 0) {
  gh repo view $repoSlug *> $null
  if ($LASTEXITCODE -eq 0) {
    git remote add origin "https://github.com/$repoSlug.git"
  } else {
    gh repo create $repoName --public --source=. --remote=origin --description "Personal website of Lynx"
  }
}

git add -A
git diff --cached --quiet
if ($LASTEXITCODE -ne 0) {
  git commit -m "Launch personal website"
} else {
  Write-Host "No changes to commit."
}

git push -u origin main

Write-Host ""
Write-Host "Done. Your site should be live at:"
Write-Host "  https://$username.github.io"
Write-Host ""
Write-Host "If this is a new repo, enable GitHub Pages:"
Write-Host "  Settings -> Pages -> Deploy from branch -> main / root"
