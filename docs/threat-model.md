# Threat Model

Autonomous engineering systems combine high-capability language models with shell, filesystem, source control, external services, and persistent state. This creates a larger attack surface than a normal assistant.

## Assets
- source code
- credentials
- developer workstation
- CI/CD identities
- production infrastructure
- persistent agent memory
- repository integrity
- audit trail

## Trust boundaries
- human -> root planner
- root planner -> subplanner
- planner -> worker
- harness -> external coding agent
- agent -> shell/filesystem
- agent -> MCP server
- MCP -> persistent memory
- repository content -> agent context
- model/provider -> orchestration runtime

## Priority attacks to test

### Repository prompt injection
Malicious instructions embedded in docs, comments, test fixtures, or generated files.

### Persistent memory poisoning
A worker or malicious repository causes durable false instructions to be stored and reused.

### Cross-project memory leakage
Knowledge from Project A appears in Project B because project identity is inferred incorrectly.

### Secret exfiltration
A task tries to make an agent read and transmit `.env`, credentials, SSH keys, or cloud tokens.

### Destructive command bait
Repository content encourages deletion, force push, reset, credential changes, or privileged operations.

### Supply-chain injection
Agent introduces an unnecessary dependency, typo-squatted package, unpinned executable, or malicious MCP/plugin.

### False verification
A worker claims tests passed when commands were blocked, skipped, or failed.

### Reviewer mutation
A supposedly independent challenger modifies the implementation it is meant to review.

### Privilege escalation
Worker attempts to escape sandbox/approval policy.

## Security principles
- least privilege
- explicit workspace identity
- root-owned final verification
- no durable memory from untrusted child roles unless reviewed
- structured audit trail
- deny-by-default destructive operations
- human approval for irreversible/high-impact actions
- pin tool/plugin versions
- separate implementation from challenge
