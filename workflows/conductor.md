---
description: Initialize or manage project context using Conductor skills
---

# /conductor - Project Context Management

$ARGUMENTS

---

## Task

This command manages project context artifacts through the Conductor system.

### Sub-commands

| Command | Action |
| ------- | ------ |
| `/conductor setup` | Initialize project context via interactive Q&A |
| `/conductor setup --resume` | Resume incomplete setup from last checkpoint |
| `/conductor scan` | Re-analyze codebase and update context artifacts |
| `/conductor validate` | Check context artifacts are current and consistent |

---

### Setup Flow

1. **Detect project type**
   - Greenfield: no `.git`, `package.json`, `requirements.txt`, `go.mod`, or `src/`
   - Brownfield: any of the above exist → auto-detect tech stack

2. **Check existing state**
   - If `conductor/setup_state.json` exists with incomplete status → offer to resume
   - If `conductor/product.md` exists → ask: resume or reinitialize?

3. **Interactive Q&A** (uses `conductor-setup` skill)
   - ONE question per turn, max 5 per section
   - Offer 2-3 suggestions + "Type your own"
   - Sections: Product → Guidelines → Tech Stack → Workflow → Code Style

4. **Generate artifacts**
   - `conductor/index.md` — navigation hub
   - `conductor/product.md` — what and why
   - `conductor/product-guidelines.md` — voice, tone, principles
   - `conductor/tech-stack.md` — languages, frameworks, infra
   - `conductor/workflow.md` — TDD, commits, reviews, verification
   - `conductor/tracks.md` — work unit registry
   - `conductor/code_styleguides/` — per-language style guides

5. **Save state** → `conductor/setup_state.json` updated after each step

---

### Scan Flow

1. **Read existing context** from `conductor/`
2. **Analyze codebase** — detect languages, deps, structure changes
3. **Diff against current artifacts** — flag stale entries
4. **Propose updates** — show what changed, ask before writing
5. **Update artifacts** — write changes, preserve manual customizations

---

### Validate Flow

Run the context validation checklist from `context-driven-development` skill:

- [ ] `product.md` reflects current vision
- [ ] `tech-stack.md` matches actual dependencies
- [ ] `workflow.md` describes current practices
- [ ] `tracks.md` has no stale or abandoned tracks
- [ ] Artifacts are mutually consistent

Report pass/fail per artifact. Offer to fix failures.

---

## Usage Examples

```
/conductor setup
/conductor setup --resume
/conductor scan
/conductor validate
```

---

## Before Starting

If no arguments provided, ask:
- First time? → run setup
- Already initialized? → scan or validate
