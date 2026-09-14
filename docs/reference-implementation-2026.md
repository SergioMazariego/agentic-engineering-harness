# Reference Implementation — September 2026

The architecture is vendor-neutral. This document describes the concrete adapters used in the first validated implementation.

## Current adapters

| Capability | Tool/model used in the validated V0.1 |
|---|---|
| Harness/runtime | DeepSeek Harness (DSH) |
| Root Planner | Claude Opus 5 |
| Subplanner | Claude Sonnet 5 |
| Implementation Worker | Claude Code |
| Challenger | Codex |
| Memory | Engram MCP |
| Verification | Root-level Git + PowerShell + project test commands |
| OS | Windows |

## Why these tools were selected

### DSH
Used as the orchestration runtime because it exposes explicit subagent providers, agent presets, tool scoping, model routing, and MCP integration.

### Claude models
Used for the planner hierarchy in this reference implementation. The architectural requirement is not "Claude"; it is:
- one strong root planner
- cheaper/faster bounded subplanners
- explicit tool policy

### Claude Code
Used as the primary mutation-capable implementation worker. The architectural requirement is a coding worker that can inspect and modify a bounded workspace and return a report.

### Codex
Used as a model-diverse independent challenger. The architectural requirement is an independent reviewer/fallback whose reasoning path is not identical to the primary implementation path.

### Engram
Used as durable memory over MCP. The architectural requirement is persistent, searchable, project-scoped memory with explicit session/project identity.

## Tested versions / environment

The initial validation was performed on:
- Windows PowerShell
- DSH 0.1.5-rc.1
- DSH optional subagent/MCP packages aligned to the same version
- Engram 1.20.0

Because DSH was in developer preview during this experiment, exact config schemas may change. Pin versions.

## Important implementation findings

### Memory must route from the active workspace
The long-lived MCP process can have a different current directory than the active repository.

Correct pattern:

```text
active workspace path
    -> start memory session(directory=active workspace)
    -> use returned project/session identity
```

Do not rely on the MCP process working directory.

### Root verification is authoritative
The unattended coding worker was able to edit but could not complete an approval-gated shell test. Root-level `npm test` was therefore the authoritative proof.

### One-shot lineage needs better observability
After one-shot children completed, the continuable-agent list returned no children. Run records were needed to reconstruct participation.

### Prompt policy is not structural policy
The test requested exactly one implementation worker. The subplanner created an additional verification worker anyway. Runtime-level cardinality/permission controls are a future requirement.

## Upstream references

- Cursor, "Towards self-driving codebases": https://cursor.com/blog/self-driving-codebases
- DeepSeek Harness: https://github.com/deepseek-ai/deepseek-harness
- DSH subagents: https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/subagent/subagent/README.md
- Claude Code programmatic use: https://code.claude.com/docs/en/headless
- OpenAI Codex App Server: https://openai.com/index/unlocking-the-codex-harness/
- Engram: https://github.com/Gentleman-Programming/engram
- Engram technical reference: https://github.com/Gentleman-Programming/engram/blob/main/DOCS.md
