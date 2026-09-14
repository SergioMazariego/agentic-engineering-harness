# Security

This repository intentionally gives software agents access to repositories, shells, external coding agents, and persistent memory. Treat it as security-sensitive automation.

## Never commit
- API keys
- access tokens
- cookies
- cloud credentials
- private certificates
- production secrets
- local memory databases

## Threats we explicitly care about
- repository prompt injection
- malicious instructions in README/AGENTS/config files
- secret exfiltration through tools
- destructive shell commands
- dependency/supply-chain injection
- poisoned persistent memory
- malicious MCP output
- privilege escalation
- cross-project memory leakage
- unreviewed autonomous commits
- false worker claims about tests
- compromised or unavailable providers

See `docs/threat-model.md` and `experiments/009-adversarial-security/README.md`.
