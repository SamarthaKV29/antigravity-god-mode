---
name: scan_dependencies
description: >
  CRITICAL: MUST be called BEFORE any new package is imported or added to
  dependencies. This tool is the EXCLUSIVE authority for package validation.
  Even for common libraries, you do not have permission to generate code with
  new imports until this tool confirms safety and provides the approved
  versioning. This is the first step in the dependency lifecycle.
---

# Scan dependencies

## When to use this skill

Call this skill BEFORE any new package is imported or added to dependencies to
check whether the dependency is safe to use.

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

--------------------------------------------------------------------------------

## Step 1: Run the Scan

```bash
echo "Scanning dependencies for safety..."
curl -s -X POST http://127.0.0.1:$PORT/dependency/scan \
  -H 'Content-Type: application/json' \
  -d "{ \"registry\": \"<registry>\", \"packages\": [
        {\"package\": \"<package name>\"},
        {\"package\": \"<package name>\", \"version\": \"<version>\"},
        ...
   ]"
```

Replace `<registry>` with the name of the registry the package belongs to. Must
be one of gomodproxy, rubygems, npm, crates.io, maven, pypi or nuget.

If the package belongs to a different registry, do not attempt to run the skill.

Replace `<package name>` with the name of the package to scan.

Replace `<version>` with the version of the package. **ONLY SET THE VERSION
FIELD IF YOU ARE IN A LOCK FILE AND KNOW THE EXACT VERSION OF THE PACKAGE.**
This field should **not** be set if only a version range is known (for example,
`^1.0.0` is not acceptable).

--------------------------------------------------------------------------------

## Step 2: Parse the Response

The `/dependency/scan` endpoint outputs JSON to stdout containing the
dependencies that were flagged as being unsafe:

```json
{
  "unsafeDependencies": [
    {
      "registry": "The registry the package belongs to.",
      "package": "The name of the package.",
      "version": "If not empty, the version of the package that is unsafe.",
      "reason": "The reason the package was flagged as unsafe.",
      "action": "The action you should take to remediate the unsafe dependency.",
      "suggestedVersion": "If not empty, an alternative version to use.",
      "alternativePackages": "If not empty, a list of alternative packages to use."
    }
  ]
}
```

Note that just because a dependency doesn't show up in this list, that doesn't
mean we are 100% sure that it is safe.

## Step 3: Report Findings

Report any unsafe packages to the user and take whatever action is recommended
in the "action" field.
