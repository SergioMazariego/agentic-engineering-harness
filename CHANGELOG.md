# Changelog

## v0.1.0 — 2026-09-12

First validated architecture.

### Added
- Root-planner / subplanner / worker hierarchy.
- Independent challenger/reviewer path.
- Durable memory with explicit workspace-based session routing.
- Root-owned authoritative verification.
- Windows reference implementation.
- End-to-end `safeDivide` validation.
- Cross-session memory validation.

### Observed limitations
- Natural-language worker-count limits are not structural limits.
- Unattended workers may be unable to execute approval-gated commands.
- One-shot child lineage is not fully represented by continuable-agent listing.
- Implicit MCP process-CWD memory routing can be wrong.
- One memory lookup path exposed inconsistent project metadata.

These limitations are tracked as future experiments rather than hidden.
