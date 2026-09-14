# DSH Reference Setup — Windows

This is the exact reference implementation used for the first validated run.

> The architecture is vendor-neutral. This guide is intentionally vendor-specific so the experiment is reproducible.

## Tested environment

- Windows PowerShell
- DSH `0.1.5-rc.1`
- `@deepseek-ai/dsh-mcp-client` `0.1.5-rc.1`
- `@deepseek-ai/dsh-subagent-claude-code` `0.1.5-rc.1`
- `@deepseek-ai/dsh-subagent-codex` `0.1.5-rc.1`
- Engram `1.20.0`
- Root planner: Claude Opus 5
- Subplanners: Claude Sonnet 5
- Primary worker: Claude Code
- Independent challenger: Codex

## 1. Align optional DSH packages with the installed DSH version

```powershell
$dshVersion = ((dsh --version) | Select-String -Pattern '\d+\.\d+\.\d+(?:-[A-Za-z0-9.]+)?').Matches.Value

dsh plugin --profile web add "@deepseek-ai/dsh-subagent-claude-code@$dshVersion"
dsh plugin --profile web add "@deepseek-ai/dsh-subagent-codex@$dshVersion"
dsh plugin --profile web add "@deepseek-ai/dsh-mcp-client@$dshVersion"
```

The validated profile package file was:

```json
{
  "name": "dsh-profile-web",
  "private": true,
  "dependencies": {
    "@deepseek-ai/dsh-mcp-client": "0.1.5-rc.1",
    "@deepseek-ai/dsh-subagent-claude-code": "0.1.5-rc.1",
    "@deepseek-ai/dsh-subagent-codex": "0.1.5-rc.1"
  },
  "dsh": {
    "profile": {
      "bundles": [
        "@deepseek-ai/dsh-base",
        "@deepseek-ai/dsh-web-app",
        "@deepseek-ai/dsh-subagent-claude-code",
        "@deepseek-ai/dsh-subagent-codex"
      ],
      "patchReload": "live"
    }
  }
}
```

## 2. Root model

Edit:

```text
%USERPROFILE%\.dsh\settings.yaml
```

Reference file:

```text
config/settings.yaml.example
```

Copy the relevant content and provide credentials through environment variables rather than hard-coding them.

## 3. Provider + Engram adapter

Edit:

```text
%USERPROFILE%\.dsh\profiles\web\cordis.patch.yml
```

Use:

```text
config/cordis.patch.yml.example
```

Important memory rule:

```text
engram mcp --tools=agent
```

Do **not** hard-code `--project`.

The long-lived MCP process can have a different cwd from the DSH coding session. The root planner therefore establishes project identity explicitly from the active workspace.

## 4. Custom agent preset

Create/copy:

```text
%USERPROFILE%\.dsh\.agent-presets\self-driving\agent.cordis.yml
```

Use:

```text
presets/self-driving/agent.cordis.yml
```

The preset implements:

```text
Root Planner
├── bounded task → Claude Code worker
├── complex scope → Sonnet subplanner
│   └── Claude Code worker
├── authoritative root verification
├── independent Codex challenge when useful
└── Engram durable memory lifecycle
```

## 5. Engram session routing

At the beginning of a coding session the root calls:

```text
mem_session_start(
  id = unique root session id,
  directory = actual active workspace cwd
)
```

Preserve the returned session/project identity.

Durable `mem_save` operations use that session id. Do not infer the project from `mem_current_project` when an explicit workspace directory is available.

## 6. Restart DSH

Stop the DSH process tree, then start it from the repository you want to work on.

Example:

```powershell
cd C:\path\to\your\repo
dsh web
```

Select the `Self-Driving Development` preset.

## 7. Reproduce the mini evaluation

Create the demo:

```powershell
.\scripts\bootstrap-demo.ps1
```

The baseline is intentionally tiny:

```js
export function add(a, b) {
  return a + b;
}
```

The end-to-end task is documented in:

```text
evals/001-e2e-safe-divide/
```

The expected route is:

```text
Root
→ one bounded planning layer
→ implementation worker
→ root diff/test verification
→ independent challenger
→ one durable project memory
```

## 8. Validate persistent memory

Start a completely new conversation in the same workspace.

Do not inspect repository files.

Initialize memory using the actual workspace directory and search for the testing/dependency convention stored in the previous run.

The validated run recalled the memory correctly across conversations.

## 9. Known implementation findings

### Natural-language policy is not enforcement
The subplanner spawned an additional verification worker even when the eval requested exactly one implementation worker.

### Worker shell verification can be blocked
The unattended coding worker could edit the repository but could not complete an approval-gated `npm test`. Root verification was therefore authoritative.

### One-shot lineage is not fully represented by live-agent listing
Completed one-shot agents require run records for complete reconstruction.

### MCP process cwd is not authoritative project identity
Explicit `mem_session_start(directory=workspace)` is required for robust multi-repo routing.

## Files you actually touch

```text
%USERPROFILE%\.dsh\settings.yaml
%USERPROFILE%\.dsh\profiles\web\package.json
%USERPROFILE%\.dsh\profiles\web\cordis.patch.yml
%USERPROFILE%\.dsh\.agent-presets\self-driving\agent.cordis.yml
```

Everything in this repository mirrors those pieces as reproducible examples.

## Before using this on important repositories

Read:

- `docs/principles.md`
- `docs/architecture.md`
- `docs/threat-model.md`
- `evals/README.md`

Treat this as an experimental engineering harness, not a guarantee of autonomous correctness.
