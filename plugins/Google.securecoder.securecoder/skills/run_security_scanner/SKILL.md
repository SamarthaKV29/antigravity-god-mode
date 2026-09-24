---
name: run-security-scanner
description: >
  Run the security scanner on source files to detect vulnerabilities. Use this
  skill to scan files for common security issues like XSS, SQL injection,
  hardcoded secrets, and other CWE-classified vulnerabilities.
---

# Run Security Scanner

This skill runs the configured scanner backend to scan source files for security
vulnerabilities. SecureCoder supports two backends: **Wiz CLI** (primary) and a
**built-in scanner** (fallback). The active backend is determined by the
`securecoder.scannerBackend` setting, which is set during onboarding.

## Step 0: Discover the API Port

The SecureCoder extension writes the API port to a well-known sidecar file on
every activation. This is the **primary** discovery mechanism because the
agent's terminal is a PTY spawned outside VS Code's terminal infrastructure and
does not receive `environmentVariableCollection` mutations.

```bash
# Primary: read from the sidecar file
if [ -f "$HOME/.securecoder/api.json" ]; then
  PORT=$(cat "$HOME/.securecoder/api.json" | grep -o '"port":[0-9]*' | grep -o '[0-9]*')
fi

# Fallback: check the env var (works in VS Code integrated terminals)
if [ -z "$PORT" ] && [ -n "$SECURECODER_API_PORT" ]; then
  PORT=$SECURECODER_API_PORT
fi
```

If `PORT` is still empty after both checks, the extension is not running. **Skip
this skill entirely** -- do not attempt to run the scanner manually and do not
ask the user.

Verify the server is reachable:

```bash
curl -s http://127.0.0.1:$PORT/config
```

If this returns a JSON response, proceed to Step 1.

--------------------------------------------------------------------------------

## Step 1: Determine the Active Scanner Backend

```bash
curl -s http://127.0.0.1:$PORT/config
```

Response:

```json
{"scannerBackend": "wiz"}
```

`scannerBackend` value | Meaning
---------------------- | ---------------------------------
`"wiz"`                | Wiz CLI is the active backend
`"semgrep"`            | Built-in scanner is active
`null`                 | No scanner configured — skip scan

If `scannerBackend` is `null`, skip the remaining steps.

--------------------------------------------------------------------------------

## Step 2: Run the Scan

```bash
echo "Requesting SecureCoder security scan for <absolute_path_to_file>..."
curl -s -X POST http://127.0.0.1:$PORT/scan \
  -H 'Content-Type: application/json' \
  -d "{\"filePath\": \"<absolute_path_to_file>\"}"
```

Replace `<absolute_path_to_file>` with the absolute path to the file being
verified (e.g. `/Users/you/project/routes/media.js`).

The extension runs the configured scanner internally and returns a normalized
response — no binary path resolution, platform detection, or backend-specific
output parsing required.

--------------------------------------------------------------------------------

## Step 3: Parse the Response

The `/scan` endpoint always returns the same `ScanResponse` shape regardless of
which backend (Wiz or built-in scanner) is active:

```json
{
  "findings": [
    {
      "subcategory": "<rule_id>",
      "message": "<human-readable description>",
      "location": {
        "path": "<absolute_file_path>",
        "range": {
          "textRange": {
            "startLine": 42,
            "startColumn": 4,
            "endLine": 42,
            "endColumn": 30
          }
        }
      },
      "labels": {
        "severity": "HIGH",
        "cwe": "CWE-22",
        "category": "security",
        "vulnerability_class": "Path Traversal"
      }
    }
  ],
  "errors": []
}
```

Key fields:

| Field                                | Description                        |
| ------------------------------------ | ---------------------------------- |
| `subcategory`                        | Stable rule identifier for the     |
:                                      : finding (used internally; do not   :
:                                      : surface to the user)               :
| `message`                            | Human-readable description of the  |
:                                      : vulnerability                      :
| `location.path`                      | Absolute path to the affected file |
| `location.range.textRange.startLine` | Line number (1-indexed)            |
| `labels.severity`                    | `HIGH`, `MEDIUM`, or `LOW`         |
| `labels.cwe`                         | CWE identifier(s), comma-separated |
:                                      : (e.g. `CWE-22,CWE-73`)             :

--------------------------------------------------------------------------------

## Step 4: Report Findings

For each item in `findings`, report:

```
**[SEVERITY] [vulnerability_class]**
File: <path>, Lines: <startLine>-<endLine>
CWE: <cwe>
Description: <message>
```

Use `labels.vulnerability_class` (e.g. `Path Traversal`, `XSS`, `SQL Injection`)
as the `[vulnerability_class]` label. Do **not** include the raw rule ID or
scanner backend name in the report — focus on the finding itself.

After listing all findings, provide a summary: total number of findings,
breakdown by severity, and list of distinct CWE categories.

-   If `findings` is empty and `errors` is empty → report scan completed with no
    vulnerabilities detected.
-   If `errors` is non-empty → report the errors and note that the scan may be
    incomplete.

--------------------------------------------------------------------------------

## Step 5: Ignore a Vulnerability (Programmatic Suppression)

If the scanner flags something that is a **false positive** or that the user has
explicitly accepted, the agent can suppress it **silently** via the local API —
no VS Code UI is shown to the user.

### Mark a finding as ignored

Use `codeSnippet` (the exact text of the flagged line) instead of `lineNumber`.
The server finds the matching line by trimmed content, so leading/trailing
whitespace differences are ignored. This makes the suppression immune to
line-number shifts caused by edits elsewhere in the file.

```bash
echo "Suppressing finding in <absolute_path_to_file>..."
curl -s -X POST http://127.0.0.1:$PORT/ignore \
  -H 'Content-Type: application/json' \
  -d '{
    "filePath": "<absolute_path_to_file>",
    "ruleId": "<subcategory_from_finding>",
    "codeSnippet": "<exact_text_of_flagged_line>",
    "vulnerabilityClass": "<vulnerability_class_from_labels>",
    "reason": "False Positive"
  }'
```

Use `content_at_line` from the finding prompt (or
`location.range.textRange.startLine` from the `/scan` response) to get the
flagged line text to use as `codeSnippet`.

If the same line text appears multiple times in the file, also pass `lineNumber`
as a hint — the server will pick the occurrence closest to that line:

```bash
-d '{
    "filePath": "...",
    "ruleId": "...",
    "codeSnippet": "<flagged_line_text>",
    "lineNumber": 42,
    "reason": "False Positive"
  }'
```

**Request fields:**

| Field                | Type   | Required | Description                  |
| -------------------- | ------ | -------- | ---------------------------- |
| `filePath`           | string | yes      | Absolute path to the         |
:                      :        :          : affected file                :
| `ruleId`             | string | yes      | Rule / vulnerability class   |
:                      :        :          : ID from the scan             :
| `codeSnippet`        | string | yes*     | Exact text of the flagged    |
:                      :        :          : line (trimmed to match)      :
| `lineNumber`         | number | yes*     | 1-indexed line number — use  |
:                      :        :          : when `codeSnippet` is absent :
:                      :        :          : or as a disambiguation hint  :
| `vulnerabilityClass` | string | no       | `labels.vulnerability_class` |
:                      :        :          : from the finding             :
| `reason`             | string | no       | Human-readable reason        |
:                      :        :          : (default\: `"Suppressed via  :
:                      :        :          : API"`)                       :

\* Provide at least one of `codeSnippet` or `lineNumber`. Prefer `codeSnippet`.

**Recommended `reason` values:**

Value              | Meaning
------------------ | ------------------
`"False Positive"` | Scanner mistake
`"Accepted Risk"`  | Known and accepted
`"Won't Fix"`      | Not prioritising

**Response on success:**

```json
{
  "success": true,
  "vulnId": "/path/to/file.js:41:injection/sql",
  "contentHash": "3a7b9f..."
}
```

The suppress record is keyed on the **content hash of the trimmed line text**,
so it survives any subsequent edits that only shift surrounding lines. The
dashboard and CodeLens refresh automatically after calling this endpoint — no
additional step required.

### Inspect the current ignore list

```bash
curl -s http://127.0.0.1:$PORT/ignored
```

```json
{
  "entries": [
    {
      "vulnId":      "/path/to/file.js:41:injection/sql",
      "ruleId":      "injection/sql",
      "filePath":    "/path/to/file.js",
      "contentHash": "3a7b9f...",
      "reason":      "False Positive",
      "timestamp":   1711000000000
    }
  ]
}
```

Use `GET /ignored` in the security audit report to identify which findings were
suppressed as false positives, and include them in the report's **False
Positives** section.

--------------------------------------------------------------------------------

## Troubleshooting

| Problem                             | Solution                               |
| ----------------------------------- | -------------------------------------- |
| `SECURECODER_API_PORT` is unset     | Extension is not active, or this       |
:                                     : terminal was opened before activation  :
:                                     : — open a new terminal                  :
| Connection refused on port          | Extension may have restarted with a    |
:                                     : new port — open a new terminal to get  :
:                                     : the updated env var                    :
| `scannerBackend: null`              | No scanner configured — direct user to |
:                                     : run `SecureCoder\: Select Security     :
:                                     : Scanner` from the Command Palette      :
| `errors` non-empty in scan response | Check the SecureCoder output channel   |
:                                     : in VS Code for details                 :
