$ErrorActionPreference = "Stop"

$demo = "$env:USERPROFILE\dsh-mini-demo"
Set-Location $demo

git reset --hard dsh-demo-baseline
git clean -fd
npm test
git status
