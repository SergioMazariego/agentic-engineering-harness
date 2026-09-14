# Architecture

## Capability graph

```mermaid
flowchart TD
    H[Human] --> R[Root Planner]
    R --> P[Subplanner]
    P --> W[Implementation Worker]
    R --> W
    R --> V[Verifier]
    R --> C[Challenger]
    R <--> M[(Durable Memory)]
    W --> Repo[(Repository)]
    V --> Repo
```

## Responsibilities

### Root Planner
Owns:
- user intent
- global plan
- delegation
- integration decisions
- final acceptance
- durable memory lifecycle

Does not own:
- routine implementation

### Subplanner
Owns:
- a bounded domain
- local decomposition
- worker instructions
- reporting upward

Does not own:
- final acceptance
- global memory lifecycle
- cross-project authority

### Worker
Owns:
- implementation of one bounded objective
- local checks it is permitted to execute
- concise report of changes/findings

Does not own:
- final completion
- durable global memory
- orchestration policy

### Verifier
Owns:
- authoritative acceptance checks
- repository diff inspection
- tests/build/lint/static analysis as required
- detection of unrelated changes

### Challenger
Owns:
- independent criticism
- requirement-gap detection
- edge-case review
- alternative reasoning

Should not silently mutate the implementation under review.

### Durable Memory
Owns:
- decisions
- stable conventions
- non-obvious discoveries
- reusable lessons
- session summaries

Does not own:
- locks
- worker status
- transient todo state
- runtime scheduling

## Control loop

```mermaid
stateDiagram-v2
    [*] --> Understand
    Understand --> Plan
    Plan --> Delegate
    Delegate --> Implement
    Implement --> Verify
    Verify --> Rework: failed
    Rework --> Delegate
    Verify --> Challenge: passed
    Challenge --> Rework: defect found
    Challenge --> Remember: accepted
    Remember --> Complete
    Complete --> [*]
```

## Isolation rule

Parallel mutation is safe only when workspaces are isolated.

```mermaid
flowchart LR
    R[Root] --> W1[Worker A]
    R --> W2[Worker B]
    W1 --> T1[Worktree A]
    W2 --> T2[Worktree B]
    T1 --> I[Integration]
    T2 --> I
    I --> V[Verification]
```
