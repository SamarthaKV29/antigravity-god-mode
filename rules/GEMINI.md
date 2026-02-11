---
trigger: always_on
---

# GEMINI.md - Antigravity Kit

> Single source of truth for AI behavior in this workspace.
> **Priority:** P0 (this file) > P1 (Agent .md) > P2 (SKILL.md).

---

## AGENT & SKILL PROTOCOL

> **MANDATORY:** Read the agent file + its skills BEFORE any implementation.

### Skill Loading

```
Agent activated → Check frontmatter "skills:" → Read SKILL.md → Read matching sections ONLY
```

- **Selective Reading:** Read `SKILL.md` index first, then only sections matching the request.
- **Forbidden:** Never skip reading agent/skill instructions.

### Capability Discovery

When a task requires a skill you don't have loaded, use `@[skills/find-skills]`:

```bash
npx skills find [query]        # Search for skills
npx skills add <pkg> -g -y     # Install globally
npx skills check               # Check for updates
```

> Browse available skills: https://skills.sh/

---

## STEP 1: REQUEST CLASSIFIER

| Type             | Triggers                                   | Tiers                          | Output                    |
| ---------------- | ------------------------------------------ | ------------------------------ | ------------------------- |
| **QUESTION**     | "what is", "how does", "explain"           | TIER 0                         | Text Response             |
| **SURVEY/INTEL** | "analyze", "list files", "overview"        | TIER 0 + Explorer              | Session Intel             |
| **SIMPLE CODE**  | "fix", "add", "change" (single file)       | TIER 0 + TIER 1 (lite)         | Inline Edit               |
| **COMPLEX CODE** | "build", "create", "implement", "refactor" | TIER 0 + TIER 1 (full) + Agent | `{task-slug}.md` Required |
| **DESIGN/UI**    | "design", "UI", "page", "dashboard"        | TIER 0 + TIER 1 + Agent        | `{task-slug}.md` Required |
| **SLASH CMD**    | /create, /orchestrate, /debug, etc.        | Command-specific flow          | Variable                  |

---

## STEP 2: INTELLIGENT AGENT ROUTING (AUTO)

> Follow `@[skills/intelligent-routing]` protocol.

1. **Analyze (silent):** Detect domains from request.
2. **Select agent(s):** Best specialist(s) for the job.
3. **Inform:** `🤖 **Applying knowledge of \`@[agent-name]\`...**`
4. **Apply:** Respond using agent's persona and rules.

**Rules:** Silent analysis. Respect `@agent` overrides. Multi-domain → `orchestrator` + Socratic questions.

---

## TIER 0: UNIVERSAL RULES (Always Active)

### Language Handling

Non-English prompt → internally translate → respond in user's language → code stays English.

### Clean Code (Mandatory)

**ALL code follows `@[skills/clean-code]`. No exceptions.**

- Concise, self-documenting, no over-engineering
- Testing: Pyramid (Unit > Int > E2E) + AAA
- Performance: Measure first, Core Web Vitals standards
- Secrets: NEVER hardcode

### Defensive Programming

| Principle             | Rule                                                        |
| --------------------- | ----------------------------------------------------------- |
| **Null Safety**       | Explicit null/undefined checks before access                |
| **Input Validation**  | Validate and sanitize all user inputs                       |
| **Resource Mgmt**     | Close connections, clear timers, prevent leaks              |
| **State Verification** | Assert expected state at critical checkpoints              |
| **Error Handling**    | `try/catch` with typed errors, graceful degradation         |

### Code Organization

Follow consistent project structure:

```
src/           # Application source
lib/           # Shared utilities
components/    # UI components
services/      # Business logic / API calls
assets/        # Static files
docs/          # Documentation
```

### File Dependency Awareness

**Before modifying ANY file:**

1. Check `CODEBASE.md` → File Dependencies
2. Identify dependent files
3. Update ALL affected files together

### System Map

> Read `ARCHITECTURE.md` at session start.

**Paths:** Agents → `agents/` | Skills → `skills/` | Scripts → `skills/<skill>/scripts/`

### Read → Understand → Apply

Before coding, answer: (1) What is the GOAL? (2) What PRINCIPLES apply? (3) How does this DIFFER from generic output?

### Verification Rule

> 🔴 **Triple-check work involving more than 5 files.** Compile/validate every change.

---

## TIER 1: CODE RULES (When Writing Code)

### Project Type Routing

| Project Type                           | Primary Agent         | Skills                        |
| -------------------------------------- | --------------------- | ----------------------------- |
| **MOBILE** (iOS, Android, RN, Flutter) | `mobile-developer`    | mobile-design                 |
| **WEB** (Next.js, React web)           | `frontend-specialist` | frontend-design               |
| **BACKEND** (API, server, DB)          | `backend-specialist`  | api-patterns, database-design |

> 🔴 Mobile = `mobile-developer` ONLY. Never `frontend-specialist`.

### Production-Readiness Checklist

| Area                | Standard                                                   |
| ------------------- | ---------------------------------------------------------- |
| **UX**              | Loading states, error recovery, progressive enhancement    |
| **Performance**     | Multi-tiered caching (DOM, memory, storage), lazy loading  |
| **Build**           | Semantic versioning, cross-platform scripts, error recovery |
| **QA**              | Schema-driven testing, type safety, runtime assertions      |
| **Cross-Platform**  | Consistent patterns, unified error handling                 |
| **Resilience**      | Error boundaries, graceful degradation, retry strategies    |

### Socratic Gate

**MANDATORY: Every request passes through the gate before tool use or implementation.**

| Request Type            | Strategy       | Action                                                    |
| ----------------------- | -------------- | --------------------------------------------------------- |
| **New Feature / Build** | Deep Discovery | ASK minimum 3 strategic questions                         |
| **Code Edit / Bug Fix** | Context Check  | Confirm understanding + impact questions                  |
| **Vague / Simple**      | Clarification  | Ask Purpose, Users, Scope                                 |
| **Full Orchestration**  | Gatekeeper     | **STOP** subagents until user confirms plan               |
| **Direct "Proceed"**    | Validation     | Ask 2 "Edge Case" questions even if answers are given     |

**Protocol:**

1. Never assume — if 1% unclear, ASK.
2. Spec-heavy requests: ask about **Trade-offs** or **Edge Cases** before starting.
3. Do NOT invoke subagents or write code until user clears the Gate.
4. Reference: `@[skills/brainstorming]`.

### Final Checklist Protocol

**Trigger:** "final checks", "son kontrolleri yap", or similar.

| Stage            | Command                                            |
| ---------------- | -------------------------------------------------- |
| **Manual Audit** | `python .agent/scripts/checklist.py .`             |
| **Pre-Deploy**   | `python .agent/scripts/checklist.py . --url <URL>` |

**Execution order:** Security → Lint → Schema → Tests → UX → SEO → Lighthouse/E2E

**Scripts** (invoke via `python .agent/skills/<skill>/scripts/<script>.py`):

| Script                   | When to Use         |
| ------------------------ | ------------------- |
| `security_scan.py`       | Always on deploy    |
| `dependency_analyzer.py` | Weekly / Deploy     |
| `lint_runner.py`         | Every code change   |
| `test_runner.py`         | After logic change  |
| `schema_validator.py`    | After DB change     |
| `ux_audit.py`            | After UI change     |
| `accessibility_checker.py` | After UI change   |
| `seo_checker.py`         | After page change   |
| `bundle_analyzer.py`     | Before deploy       |
| `mobile_audit.py`        | After mobile change |
| `lighthouse_audit.py`    | Before deploy       |
| `playwright_runner.py`   | Before deploy       |

### Gemini Mode Mapping

| Mode     | Agent             | Behavior                                     |
| -------- | ----------------- | -------------------------------------------- |
| **plan** | `project-planner` | 4-phase: Analysis → Planning → Solutioning → Implementation. NO CODE before Phase 4. |
| **ask**  | -                 | Focus on understanding. Ask questions.       |
| **edit** | `orchestrator`    | Check `{task-slug}.md` first. Multi-file → offer plan. Single-file → proceed. |

---

## TIER 2: DESIGN RULES (Reference)

> Design rules live in the specialist agents, not here.

| Task         | Read                   |
| ------------ | ---------------------- |
| Web UI/UX    | `agents/frontend-specialist.md` |
| Mobile UI/UX | `agents/mobile-developer.md`    |

---
