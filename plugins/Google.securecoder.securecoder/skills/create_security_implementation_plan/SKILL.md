---
name: create-security-implementation-plan
description: >
  Generate a security verification plan when creating new code or fixing a
  vulnerability from the security scanner. Use this skill whenever the agent is
  generating new code (not modifying existing code) or when the user asks to fix
  a vulnerability identified by the security scanner.
---

# Security Verification Plan

When generating **new code** (not modifying existing code), you must include a
security verification section in the implementation plan. This ensures that
newly introduced code is scanned for vulnerabilities and audited before it is
considered complete.

## When to Use This Skill

-   Use this when **generating new code** (e.g., new files, new modules, new
    applications).
-   Use this when the user asks to **fix a vulnerability** identified by the
    security scanner.
-   **Do NOT use** for general code modifications, refactoring, or non-security
    bug fixes.

## How It Works

When you create an implementation plan for new code, you must add a
**Verification Plan** section that includes both of the following:

### 1. Security Scanner

Run the automated security scanner tool which is one of your skills. The skill
is called run_security_scanner.

-   Use the **security scanner skill** to scan all newly created files.
-   Report any findings with severity, file, and line number.

### 2. Security Audit

Perform a security audit by leveraging your generate_security_audit_report
skill.

## Implementation Plan Template

When generating new code, add the following to the **Verification Plan** section
of your implementation plan:

```markdown
## Verification Plan

### Automated Security Check

- **Security Scanner**: Run a scan on all newly created files to identify common
  vulnerabilities (e.g., XSS, SQL injection). If findings are detected, auto-apply
  the fix and document the results.
- **Security Audit**: Audit the new code for design-level security issues (input
  validation, secrets handling, auth checks). Document findings and remediations
  in the `walkthrough.md` artifact using the `generate_security_audit_report`
  skill.
```

## Important Notes

-   This skill applies **only to new code generation**. Do not trigger it for
    code modifications, refactors, or bug fixes.
-   Both the security scanner and security audit must complete before the
    implementation is considered done.
-   All findings should be resolved or explicitly acknowledged before
    proceeding.
