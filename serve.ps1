# Preview the site locally before pushing to GitHub.
# Usage (PowerShell):
#   cd C:\Users\LYNX\lynx.github.io
#   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#   .\serve.ps1
#
# Then open: http://127.0.0.1:8080
# Stop the server: Ctrl+C

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$port = 8080

if (Get-Command python -ErrorAction SilentlyContinue) {
  Write-Host "Serving at http://127.0.0.1:$port (Python)"
  python -m http.server $port
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
  Write-Host "Serving at http://127.0.0.1:$port (py launcher)"
  py -m http.server $port
} else {
  Write-Host "Python was not found. Options:"
  Write-Host "  1. Install Python from https://www.python.org/downloads/"
  Write-Host "  2. Or run: npx -y serve . -l $port"
  exit 1
}
