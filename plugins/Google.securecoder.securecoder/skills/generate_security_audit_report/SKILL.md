---
name: generate-security-audit-report
description: >
  Generate a security audit report as a walkthrough artifact after completing
  code generation. This skill documents all vulnerabilities that were detected
  and fixed during the session, providing users with a comprehensive security
  overview.
---

# Generate Security Audit Report

After completing code generation, produce a **Security Audit** walkthrough
artifact that documents every vulnerability detected and remediated during the
session. This gives users full visibility into the security posture of the
generated code.

## When to Use This Skill

-   Use this skill at the **end of a code generation task**, after all security
    scanning and fixing is complete.
-   Use this skill when the `create_security_implementation_plan` skill's
    verification plan has been executed and vulnerabilities were found.
-   Use this skill whenever `run_security_scanner` was invoked during the
    session and produced findings.
-   **Do NOT use** if no security scan was performed or no code was generated.

## Prerequisites

Before generating this report you must have:

1.  Run the `run_security_scanner` skill on all generated files.
2.  Applied fixes for any detected vulnerabilities using file editing tools or
    manual remediation.
3.  Re-scanned fixed files to confirm the vulnerabilities are resolved.

## Step 1: Collect Scan Data

Gather the following from the session:

-   **Initial scan results**: The JSON output from `run_security_scanner` before
    any fixes.
-   **Remediation actions**: What was changed and in which files.
-   **Post-fix scan results**: The JSON output from `run_security_scanner` after
    fixes were applied.
-   **Ignored findings**: Fetch the current suppression list from the local API:

    ```bash
    curl -s http://127.0.0.1:$PORT/ignored
    ```

    Each `IgnoredEntry` has `ruleId`, `filePath`, `reason`, and `timestamp`. Map
    the `reason` to a report status using the table below.

## Step 2: Generate the Walkthrough Artifact

Create or update the `walkthrough.md` artifact with a **SecureCoder Security
Audit** section. The report must include the sections below.

> [!NOTE] If the `run_poc` skill was also used during this session, a `## PoC
> Verification` section will already exist in `walkthrough.md`. Write the
> **SecureCoder Security Audit** section **before** that section, so post-fix
> evidence flows naturally: Audit → PoC Verification. Similarly, if
> `determine_threat_model` was used, the `## Security Threat Model` section
> lives in `implementation_plan.md` — you do not need to copy it here, just
> reference it as prior context.

### Header

```markdown
# SecureCoder Security Audit

**Status**: Completed
**Scanned Files**: <count>
**Vulnerabilities Found**: <count>
**Vulnerabilities Fixed**: <count>
```

> [!TIP] SecureCoder automatically scans your working directory for security
> flaws in near real-time, executing `run_security_scanner` behind the scenes
> and dynamically generating targeted fixes.

### Vulnerability Report

Present all findings in a table with the following columns:

| Column           | Description                                              |
| ---------------- | -------------------------------------------------------- |
| Vulnerability ID | A unique ID for the finding (e.g., `CS-XSS-001`)         |
| File             | The file containing the vulnerability                    |
| Line             | The line number where the vulnerability occurs           |
| Description      | A clear, human-readable description of the vulnerability |
:                  : including the attack vector, the affected code pattern,  :
:                  : and why it is dangerous                                  :
| Severity         | The severity from the scan output: `High`, `Medium`, or  |
:                  : `Low`                                                    :
| Status           | `Fixed` or `Open`                                        |
| Remediation      | A concise explanation of the fix that was applied        |

Map scanner severity values to the report as follows:

Scanner Severity | Report Severity
---------------- | ---------------
`ERROR`          | `High`
`WARNING`        | `Medium`
`INFO`           | `Low`

**Status** column values and their sources:

Status           | When to use
---------------- | -----------------------------------------------------
`Fixed`          | Vulnerability was patched during the session
`Open`           | Vulnerability detected but not yet addressed
`False Positive` | Ignored entry with reason containing "False Positive"
`Accepted Risk`  | Ignored entry with reason containing "Accepted Risk"
`Won't Fix`      | Ignored entry with reason containing "Won't Fix"
`Suppressed`     | Ignored entry with any other reason

#### Vulnerability ID Format

Use the format `CS-<CLASS>-<NNN>` where:

-   `CS` = SecureCoder prefix
-   `<CLASS>` = Short vulnerability class code (e.g., `XSS`, `SQLI`, `EXEC`,
    `SECRETS`, `PATH`)
-   `<NNN>` = Sequential number, zero-padded to 3 digits

#### Example Table

```markdown
| Vulnerability ID | File | Line | Description | Severity | Status | Remediation |
|---|---|---|---|---|---|---|
| CS-XSS-001 | app.js | 10 | Cross-Site Scripting (XSS) via `innerHTML`. The unsanitized `city` input string was being rendered directly into the DOM inside the `.error` element. This could permit arbitrary JavaScript execution if malicious payload strings were used as the search term. | High | Fixed | Replaced `innerHTML` assignment with `textContent`, ensuring that all characters are safely encoded as text literals by the browser before rendering. |
| CS-PATH-001 | routes.js | 42 | Path Traversal via unsanitised `req.params.file`. | Medium | False Positive | The path is validated upstream by a middleware layer not visible in the scanned file. Suppressed via API. |
```

### False Positives Summary

After the main vulnerability table, add a **False Positives** section if any
entries in `GET /ignored` have a reason mapping to `False Positive`, `Accepted
Risk`, or `Won't Fix`:

```markdown
## Suppressed Findings

| Finding | File | Reason | Suppressed At |
|---|---|---|---|
| SQL Injection | db.js | Accepted Risk - parameterised query used at call site | 2024-03-20 |
| Path Traversal | routes.js | False Positive - path validated by upstream middleware | 2024-03-20 |
```

Include this section even if there is only one suppressed finding. If there are
no suppressed findings, omit this section entirely.

## Step 3: Surface the Report to the User

When presenting the completed work to the user:

1.  **In your response message**, highlight the security impact of SecureCoder:

    -   Mention that SecureCoder was running actively during code generation.
    -   State the number and severity of vulnerabilities detected.
    -   Name the specific files and vulnerability types found.
    -   Explain that fixes were automatically applied before the user needed to
        run the code.

2.  **Attach the walkthrough artifact** and link to it so the user can open and
    review the full security audit report. Make sure its formatted correctly.

### Example Response

```
I've completed building the initial version of the Weather App!

During the generation process, **SecureCoder** was running actively in the background. It detected two critical Cross-Site Scripting (XSS) vulnerabilities in `app.js`.

I was able to automatically intervene and patch these vulnerabilities before you even needed to run the code.

I've attached the complete **SecureCoder Security Audit** for your review which details exactly what was found and how it was remediated.
```

## Step 4: Handle Edge Cases

| Scenario                            | Action                                 |
| ----------------------------------- | -------------------------------------- |
| No vulnerabilities found            | Still generate the report with a "No   |
:                                     : vulnerabilities detected" status and   :
:                                     : the list of scanned files. This        :
:                                     : confirms the scan was performed.       :
| Vulnerabilities found but not fixed | Mark them as `Open` in the Status      |
:                                     : column and explain why they were not   :
:                                     : auto-fixed (e.g., requires manual      :
:                                     : review, complex business logic).       :
| Scanner errors                      | Include any errors from the `errors`   |
:                                     : array in the JSON output in a separate :
:                                     : "Scanner Errors" section.              :
| Multiple scan passes                | Document each pass. Show the initial   |
:                                     : findings, the fix applied, and the     :
:                                     : results of the re-scan.                :
