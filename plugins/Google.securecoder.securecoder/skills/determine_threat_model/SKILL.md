---
name: determine-threat-model
description: >
  Build a threat model for the current repository or component. Use this skill
  to identify entry points, trust boundaries, sensitive data paths, and priority
  review areas. The resulting threat model artifact is used by other skills to
  contextualize scanner findings and distinguish true positives from false
  positives.
---

# Determine Threat Model

This skill produces a **threat model artifact** — a short security summary of
how a repository or component works. Other skills
(`create_security_implementation_plan`, `generate_security_audit_report`) use
this artifact as context for scan prioritization, finding evaluation, and audit
reports.

## When to Use This Skill

-   Use this when you need to **evaluate whether a scanner finding is a real
    vulnerability or a false positive**.
-   Use this when the user asks for a **threat model** or **security overview**
    of a component.
-   Use this when **starting a security review** of a new or unfamiliar
    component.
-   **Do NOT use** for general code modifications or non-security tasks.

## Step 1: Identify Component Purpose

Examine the repository or component to answer:

-   What does this component do?
-   Who are its consumers (users, other services, internal tools)?
-   What is the deployment context (public internet, internal network, CLI)?

Look at READMEs, top-level source files, configuration files, and build
configuration files to build this understanding.

## Step 2: Map Entry Points and Untrusted Inputs

Identify all points where external data enters the system:

Entry Point Type       | Examples
---------------------- | -------------------------------------------------
HTTP / gRPC endpoints  | API handlers, servlet routes, RPC service methods
CLI arguments          | Flags, positional args, stdin
File inputs            | Config files, uploaded files, temp files
Environment variables  | Feature flags, secrets passed via env
Database / queue reads | Messages from Pub/Sub, rows from untrusted tables
Inter-process comms    | Shared memory, pipes, sockets

For each entry point, note:

-   Whether the input is **trusted** (e.g., from an authenticated internal
    service) or **untrusted** (e.g., from an end user).
-   What validation or sanitization is applied.

## Step 3: Identify Trust Boundaries and Auth Assumptions

Document:

-   **Authentication**: How are callers identified? (OAuth, mTLS, API keys,
    none)
-   **Authorization**: How are permissions checked? (IAM, ACLs, role checks,
    none)
-   **Implicit trust**: Are there assumptions like "only trusted backend
    services call this" or "only internal users have access"?
-   **Boundary crossings**: Where does data move between trust zones (e.g.,
    frontend → backend, service → database, user → admin)?

## Step 4: Map Sensitive Data Paths and Privileged Actions

Trace where sensitive data flows through the component:

-   **Secrets**: API keys, tokens, credentials — where are they read, stored,
    and transmitted?
-   **PII**: User data, email addresses, IP addresses — how are they handled and
    logged?
-   **Privileged operations**: File writes, shell execution, network calls,
    database mutations, permission grants.

## Step 5: Identify Priority Review Areas

Based on Steps 1–4, list the areas that should be reviewed first. Prioritize by:

1.  Code that handles **untrusted input** with **insufficient validation**.
2.  Code that performs **privileged actions** (exec, file I/O, network calls).
3.  Code that crosses **trust boundaries** without proper auth checks.
4.  Code that handles **sensitive data** (secrets, PII, tokens).

## Step 6: Evaluate Scanner Findings Against the Threat Model

When scanner results are available, evaluate each finding against the threat
model context. For each finding, determine:

-   **Is the flagged code reachable from an untrusted entry point?**
-   **Does the threat model's auth/trust context mitigate the risk?**
-   **Is the vulnerability exploitable given the deployment context?**

Classify each finding as:

Disposition             | Meaning
----------------------- | -------------------------------------------------
**True Positive**       | The finding is a real, exploitable vulnerability
                        | given the threat model.
**False Positive**      | The finding is not exploitable because of trust
                        | boundaries, auth, or intended functionality.
**Needs Manual Review** | Insufficient context to determine; flag for human
                        | review.

Provide a one-line rationale for each classification.

## Step 7: Write the Threat Model into the Implementation Plan

Create or update the `implementation_plan.md` **artifact** with a `## Security
Threat Model` section. This surfaces the threat model directly in the
Antigravity planning UI alongside the fix plan. Other skills
(`create_security_implementation_plan`, `generate_security_audit_report`, and
`run_poc`) should read the `## Security Threat Model` section from
`implementation_plan.md` when they need threat model context.

Use the following structure for the section:

```markdown
## Security Threat Model

### Component Overview
<Brief description of the component, its consumers, and deployment context.>

### Entry Points and Untrusted Inputs
| Entry Point | Type | Trusted? | Validation |
|---|---|---|---|
| <endpoint> | <type> | Yes/No | <description> |

### Trust Boundaries and Auth Assumptions
- **Authentication**: <method>
- **Authorization**: <method>
- **Implicit trust**: <assumptions>

### Sensitive Data Paths
| Data Type | Source | Destination | Protection |
|---|---|---|---|
| <type> | <source> | <dest> | <protection> |

### Privileged Actions
| Action | Location | Guard |
|---|---|---|
| <action> | <file:line> | <auth check or none> |

### Priority Review Areas
1. <area and rationale>
2. <area and rationale>

### Finding Dispositions
| Finding | Severity | Disposition | Rationale |
|---|---|---|---|
| <vulnerability_class> at <file:line> | <severity> | True Positive / False Positive / Needs Review | <one-line reason> |
```

## Important Notes

-   The `## Security Threat Model` section in `implementation_plan.md` is the
    **first thing to revise** if scanner findings feel off — it provides the
    context that drives prioritization.
-   You need to take into account the intention and threat model of the
    component to determine if an issue is a valid security issue or intended
    functionality.
-   You can fetch entry points, web entry points, and user actions to help
    determine the intended usage of the component.
-   Both the `create_security_implementation_plan` and
    `generate_security_audit_report` skills should reference the `## Security
    Threat Model` section of `implementation_plan.md` when it exists.
