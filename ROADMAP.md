# Roadmap — Proof Before Scale

The roadmap is organized by **claims we want to earn**, not features we want to collect.

## V0.1 — Hierarchical execution
**Claim:** A root planner can decompose a task, delegate implementation, independently verify it, invoke a model-diverse challenger, and persist durable memory.

Status: **validated** on the mini E2E task.

## V0.2 — Role conformance
**Claim:** Planner, worker, verifier, challenger, and memory roles can be enforced structurally rather than only by prompt.

Prove:
- planners cannot mutate
- workers cannot declare final acceptance
- challenger cannot modify
- memory cannot act as coordination bus
- worker-count/concurrency limits are runtime-enforced

## V0.3 — Multi-project memory isolation
**Claim:** Memories route to the correct repository across many workspaces and never leak into the wrong project.

Prove:
- 3+ repos
- identical topic names
- cross-session recall
- rename/remotes/monorepo cases
- explicit ambiguous-project handling

## V0.4 — Failure recovery
**Claim:** The system degrades safely when a component fails.

Inject:
- worker unavailable
- challenger quota exhausted
- timeout
- malformed child response
- test failure
- shell approval denial
- MCP outage
- memory write failure

Measure:
- detection
- retry behavior
- fallback behavior
- rollback
- human escalation

## V0.5 — Parallel isolated workers
**Claim:** Parallelism improves wall-clock time without repository corruption.

Use:
- Git worktrees or equivalent workspace isolation
- explicit ownership boundaries
- deterministic merge/integration rules

Measure:
- speedup
- conflicts
- duplicated work
- merge defects
- token overhead

## V0.6 — Routing policy
**Claim:** The orchestrator can choose the cheapest/correct worker class for a task.

Compare:
- same-model worker
- stronger-model worker
- model-diverse challenger
- no challenger

Measure:
- success
- latency
- cost/tokens
- defect detection
- escalation rate

## V0.7 — Single strong agent vs hierarchy
**Claim:** Hierarchical orchestration is useful on a defined task class.

Run a fixed corpus (target: 20+ tasks):
A. one strong agent
B. hierarchical harness

Measure:
- task success
- test pass rate
- unrelated changes
- retries
- wall-clock time
- token usage
- human interventions
- defects found after completion

## V0.8 — Long-horizon engineering
**Claim:** The system preserves intent and correctness over long tasks.

Prove:
- multi-hour run
- 20+ commits or equivalent steps
- context compaction
- interruption/resume
- evolving requirements
- durable memory recovery

## V0.9 — Completion correctness
**Claim:** "Done" means acceptance criteria are actually satisfied.

Build:
- explicit acceptance contract
- root verifier
- negative tests
- incomplete-implementation traps
- hallucinated-test detection

## V0.10 — Adversarial security
**Claim:** The harness can resist hostile repository/tool/memory inputs.

Attack:
- prompt injection in repo
- fake system instructions in docs
- malicious MCP content
- memory poisoning
- secret exfiltration prompts
- destructive command bait
- dependency typosquatting
- privilege escalation

## V1.0 — Engineering harness
Target properties:
- portable role contracts
- reproducible eval corpus
- runtime-enforced invariants
- multi-provider adapters
- isolated parallel work
- reliable memory
- auditable lineage
- failure recovery
- security test suite
- clear human authority boundaries

## Beyond coding

Apply the same role contracts to:
- vulnerability validation
- detection engineering
- DFIR artifact analysis
- incident-response automation
- BAS scenario generation
- detection-as-code review
- security architecture review

The research question becomes: **which orchestration principles survive the domain change?**
