# Result — Cross-Session Persistent Memory

A new conversation was started with no repository inspection, shell use, or delegation.

The root initialized memory with:

```text
directory = C:\Users\smazariego\dsh-mini-demo
```

Memory resolved:

```text
project: dsh-mini-demo
project_source: git_root
```

It retrieved the durable convention written in the previous session:

- tests use Node built-in `node:assert/strict`
- `npm test` runs `node test.js`
- the project intentionally has no dependencies/devDependencies
- future changes should preserve the zero-external-dependency convention

The remembered observation was identified as:

```text
obs-2f0ba1ff5627d036
```

## Integrity finding

A direct observation lookup surfaced a header naming `deepseek-harness` while the session/search path and observation body were associated with `dsh-mini-demo`.

This is treated as a project-resolution/metadata inconsistency, not a memory-content failure.

**Architectural response:** establish and preserve project identity at session start from the active workspace. Do not trust an implicit long-lived MCP process cwd.
