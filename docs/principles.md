# Durable Principles

This file is intentionally vendor-neutral.

## 1. Intent has one owner
One root role owns the user's objective until completion. Delegation distributes work, not accountability.

## 2. Planning and implementation are different capabilities
A planner that also edits everything tends to collapse into a worker. Separate decomposition from mutation.

## 3. Workers are bounded and disposable
Workers receive one clear objective, explicit scope, constraints, and acceptance criteria. They should not require global authority.

## 4. Verification is authoritative
Worker self-report is evidence, not proof. A separate verifier must inspect changes and run the acceptance checks that matter.

## 5. Independent challenge is different from implementation
A challenger should be free to disagree with the implementation path. Model/provider diversity can be useful here, but diversity is a tactic, not the principle.

## 6. Memory is knowledge, not coordination
Persistent memory stores durable decisions, discoveries, conventions, and lessons. It must not become a lock manager, task queue, or ephemeral status board.

## 7. Project identity must be explicit
Long-lived tool processes may have a different working directory from the active workspace. Route memory and state from the authoritative workspace context.

## 8. Parallelism requires isolation
Do not let independent mutation-capable workers share one working tree. Parallel work should use isolated workspaces/worktrees and explicit integration.

## 9. Observability is part of correctness
A system that cannot explain which agent acted, with what permissions, on which workspace, and with what result is not ready for high-trust autonomy.

## 10. Policies should be structural when possible
Natural-language instructions are useful but not equivalent to runtime enforcement. Concurrency limits, write permissions, reviewer immutability, and approval gates should become machine-enforced invariants.

## 11. Degrade safely
Quota exhaustion, unavailable providers, MCP failure, sandbox denial, and malformed outputs are normal operating conditions. Failure should reduce capability, not silently reduce assurance.

## 12. Completion requires evidence
"Done" should be a state transition backed by acceptance criteria, not a worker's confidence statement.

## 13. Human authority should be explicit
Define which operations require human approval: destructive commands, production deployment, secret access, irreversible migrations, external communication, or privileged actions.

## 14. Portability is an architectural test
If swapping a model, coding agent, memory provider, or orchestration runtime requires redesigning the whole system, the architecture is coupled to products rather than capabilities.
