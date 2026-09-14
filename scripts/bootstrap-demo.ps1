$ErrorActionPreference = "Stop"

$demo = "$env:USERPROFILE\dsh-mini-demo"

New-Item -ItemType Directory -Force "$demo\src" | Out-Null
Set-Location $demo

@'
{
  "name": "dsh-mini-demo",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "test": "node test.js"
  }
}
'@ | Set-Content package.json

@'
export function add(a, b) {
  return a + b;
}
'@ | Set-Content src\math.js

@'
import assert from "node:assert/strict";
import { add } from "./src/math.js";

assert.equal(add(2, 3), 5);

console.log("All tests passed");
'@ | Set-Content test.js

if (-not (Test-Path ".git")) {
    git init
}

git add .
git commit -m "baseline"
git tag -f dsh-demo-baseline

npm test
git status
