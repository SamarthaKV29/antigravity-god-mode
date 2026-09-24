---
name: run-poc
description: >
  Generate and reason through a Proof-of-Concept (PoC) to verify that a security
  fix is effective. Use this skill after a vulnerability has been identified and
  a fix patch has been applied. The resulting PoC artifact demonstrates whether
  the vulnerability is still exploitable after remediation.
---

# Run PoC

This skill produces a **PoC verification artifact** — a script that would
exploit a known vulnerability, paired with a step-by-step analysis of why the
fix prevents exploitation. It is used as the final verification step in the
security remediation pipeline, after `determine_threat_model`,
`create_security_implementation_plan`, and the fix patch have been applied.

## When to Use This Skill

-   Use this **after a fix patch has been applied** to verify the remediation is
    effective.
-   Use this when you need to **validate that a scanner finding is no longer
    exploitable** after code changes.
-   **Do NOT use** before a fix has been applied — use `determine_threat_model`
    to evaluate findings before remediation.
-   **Do NOT use** for general code modifications or non-security tasks.

## Prerequisites

Before running this skill, ensure:

-   The `implementation_plan.md` artifact contains a `## Security Threat Model`
    section (produced by `determine_threat_model`).
-   A fix patch has been applied to address the vulnerability.
-   You know the specific vulnerability type, affected file(s), and the finding
    from the scanner or threat model.

## Step 1: Review the Threat Model and Fix

Read the `## Security Threat Model` section of `implementation_plan.md` and the
applied fix patch. Focus only on findings classified as **True Positive** in the
threat model:

-   What true positive vulnerability was identified (type, severity, affected
    code path).
-   What entry points and trust boundaries are relevant to this finding.
-   What the fix changed and why it should prevent exploitation.

## Step 2: Describe the PoC

Describe a concrete exploit scenario that would demonstrate the vulnerability.
This should include:

-   What input or request an attacker would craft.
-   Which code path the exploit follows through the user's (now patched) code.
-   What the expected malicious outcome would be if the code were still
    vulnerable (e.g., unauthorized file read, injected script execution,
    privilege escalation).

### Vulnerability-Specific PoC Examples

Use these as guidance for describing the PoC based on the vulnerability type:

#### Path Traversal

-   **Exploit scenario:** An attacker sends a request like `GET
    /files?name=../../etc/passwd` to read files outside the intended directory.
-   **What to trace:** Does the patched code normalize or reject `../` sequences
    before constructing the file path? Does it validate the resolved path stays
    within the allowed directory?

#### Cross-Site Scripting (XSS)

-   **Exploit scenario:** An attacker submits a form field or URL parameter
    containing `<script>document.cookie</script>` which gets rendered in the
    HTML response without escaping.
-   **What to trace:** Does the patched code sanitize or escape user input
    before inserting it into the DOM or HTML template? Does the fix apply to all
    output contexts (HTML body, attributes, JavaScript)?

#### SQL Injection

-   **Exploit scenario:** An attacker submits a login form with username `admin'
    OR '1'='1` to bypass authentication or extract data.
-   **What to trace:** Does the patched code use parameterized queries or
    prepared statements instead of string concatenation? Does the fix cover all
    query construction points?

#### Server-Side Request Forgery (SSRF)

-   **Exploit scenario:** An attacker provides a URL like
    `http://169.254.169.254/latest/meta-data/` in a webhook or image-fetch field
    to access internal cloud metadata.
-   **What to trace:** Does the patched code validate and restrict the target
    URL/hostname before making the request? Does it block internal IP ranges and
    cloud metadata endpoints?

#### Insecure Deserialization

-   **Exploit scenario:** An attacker sends a crafted serialized object (e.g., a
    malicious pickle payload or JSON with `__proto__` pollution) that executes
    arbitrary code when deserialized.
-   **What to trace:** Does the patched code use safe deserialization methods?
    Does it validate or restrict the types that can be deserialized?

## Step 3: Reason Through the PoC

Do **not** execute the PoC script. Instead, reason through it step by step:

1.  Trace the data flow from the PoC's exploit input through the patched code.
2.  Identify where the fix intercepts or neutralizes the exploit.
3.  Determine the expected outcome — the exploit should fail because of the fix.
4.  If the exploit would still succeed, flag the fix as incomplete and explain
    why.

## Step 4: Write the PoC Verification into the Walkthrough

Create or update the `walkthrough.md` **artifact** with a `## PoC Verification`
section. This surfaces the PoC analysis in the Antigravity walkthrough UI
alongside the Security Audit, giving all post-fix evidence in one place.

Use the following structure for the section:

```markdown
## PoC Verification

### <Vulnerability ID or Description>

#### Vulnerability Summary
| Field               | Value                              |
|---------------------|------------------------------------|
| Type                | <e.g., Path Traversal, XSS>        |
| Severity            | <e.g., High, Medium>               |
| Affected File       | <file:line>                        |
| Vulnerability Class | <e.g., Path Traversal, XSS>        |

#### Fix Summary
<Brief description of what the fix changed and why.>

#### Reasoning Analysis
| Step | Description              | Result                             |
|------|--------------------------|------------------------------------|
| 1    | <Trace exploit input>    | <What happens>                     |
| 2    | <Where fix intercepts>   | <How it blocks>                    |
| 3    | <Expected outcome>       | Exploit blocked / Exploit succeeds |

#### Conclusion
<**Fix verified** or **Fix incomplete** with explanation.>
```

If multiple vulnerabilities were verified, add a subsection (`###`) for each one
under the single `## PoC Verification` heading.

## Important Notes

-   The `## PoC Verification` section in `walkthrough.md` is read by the
    `generate_security_audit_report` skill to cross-reference fix outcomes.
-   If the reasoning analysis shows the fix is incomplete, recommend specific
    additional changes needed.
-   This skill complements but does not replace re-running the security scanner
    after a fix — the scanner checks for known patterns, while the PoC tests
    actual exploitability.
