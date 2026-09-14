# Experiment Method

Every experiment should be written so another engineer can reproduce or falsify it.

## Required template

### Hypothesis
A falsifiable claim.

### Baseline
What happens without the proposed orchestration feature?

### Treatment
What exactly changes?

### Task corpus
Use the same tasks across conditions whenever possible.

### Metrics
Potential metrics:
- task success
- tests passed
- acceptance criteria satisfied
- wall-clock time
- model tokens
- provider cost
- number of delegations
- number of retries
- root interventions
- human interventions
- unrelated file changes
- defects found by independent review
- merge conflicts
- memory routing correctness
- memory retrieval precision
- agent-role violations

### Failure injection
For resilience experiments, state exactly what will fail and when.

### Evidence
Keep:
- run id
- tool/provider route
- model when observable
- git diff/stat
- tests
- errors
- memory ids
- lineage
- environment versions

### Conclusion
State what the experiment actually supports. Do not generalize beyond the data.
