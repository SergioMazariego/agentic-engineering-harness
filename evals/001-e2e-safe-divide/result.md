# Result — E2E Execution

## Outcome

| Component | Result |
|---|---|
| Root planner | PASS |
| Subplanner | PASS with one deviation |
| Implementation worker | PASS |
| Independent challenger | PASS |
| Memory session routing | PASS |
| Memory write | PASS |
| Root `npm test` | PASS |

## Agent/provider evidence

- Root: `claude-opus-5` in the runtime configuration.
- Subplanner: routed through the configured Sonnet subplanner contract.
- Implementation: Claude Code provider.
- Challenger: Codex provider.
- Exact delegated model names were not always emitted by the child result surface.

## Repository evidence

```text
src/math.js | 7 +++++++
test.js     | 6 +++++-
2 files changed, 12 insertions(+), 1 deletion(-)
```

Root-level `npm test`:

```text
All tests passed
```

Only `src/math.js` and `test.js` changed. No dependency changes.

## Challenger result

The independent challenger reported no correctness defect, requirement violation, or unnecessary change.

## Deviations / findings

### 1. Extra verification worker
The subplanner created a second coding-agent call for verification even though the prompt requested exactly one worker. The implementation itself came from one worker, but worker cardinality was not structurally enforced.

**Lesson:** prompt constraints are not runtime invariants.

### 2. Approval-gated shell verification
The unattended coding worker could not authoritatively run `npm test` because the environment required an approval it could not request.

**Lesson:** worker test claims are not authoritative in this environment. Root verification is required.

### 3. One-shot observability
Completed one-shot children did not remain in the continuable-agent list.

**Lesson:** run records / explicit tracing are required for complete lineage.

### 4. Memory routing
Implicit memory project detection could resolve the harness repository. Explicit session initialization with the active workspace directory correctly resolved `dsh-mini-demo`.

**Lesson:** project identity must come from authoritative workspace context.
