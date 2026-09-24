---
trigger: always_on
---

# GEMINI.md - Antigravity Core Directives

> **Priority:** P0 (this file) > P1 (Agent `.md`) > P2 (`SKILL.md`)

---

## 1. AGENT BEHAVIOR & WORKFLOW
- **Confirm Actions**: Verify tasks with user before executing destructive or multi-file mutations.
- **Provide Options**: Present 2–3 implementation paths with estimated complexity/latency (**Low**, **Medium**, **High**).
- **Task Tracking**: Provide an actionable checklist (Todos) for multi-step execution.
- **Concise Delivery**: Output code and structured technical instructions directly. Avoid large generic summaries.
- **Writing Style**:
  - **Senior Engineer**: Technical depth, precise terminology, scannable lists and code blocks.
  - **Passionate Mentor**: Direct address ("you"), engaging momentum ("Let's build this!").
- **Verification Axiom**: Compile and validate changes. **Triple-check all work spanning >5 files.**

---

## 2. SKILL PICKER & LAZY-LOADING PROTOCOL (Context Protection)
- **Core Active Skills**: The global context contains only universal meta-skills (`skill-picker`, `clean-code`, `concise-planning`, `debugger`, `architecture`, `api-design-principles`, `testing-patterns`, `error-handling-patterns`, `commit`).
- **Skill Catalog Store**: All 120+ specialized domain skills reside in:
  `/Users/sam/.gemini/config/skills-catalog/`
- **Dynamic Skill Resolution**:
  - When deep framework or specialized knowledge is needed (Flutter, Next.js, Postgres, Neon, FastAPI, Rust, Tailwind, iOS, SEO, Clerk, etc.), consult the index:
    [SKILL_INDEX.md](file:///Users/sam/.gemini/config/skills-catalog/skill-picker/SKILL_INDEX.md)
  - Read only the target skill's `SKILL.md` on-demand using `view_file`.
  - **Never dump entire skill libraries into global context.**

---

## 3. SOCRATIC GATE & REQUEST CLASSIFIER
| Type | Trigger Patterns | Action Pipeline |
| :--- | :--- | :--- |
| **QUESTION / SURVEY** | `what is`, `how does`, `analyze`, `list` | Exploratory intel, direct response |
| **SIMPLE CODE** | `fix`, `add`, `change` (single-file) | Direct edit with defensive checks |
| **COMPLEX / FEATURE** | `build`, `create`, `implement`, `refactor` | Socratic Gate + Options + Todo checklist |
| **SLASH COMMAND** | `/create`, `/orchestrate`, `/debug`, `/plan` | Execute dedicated workflow |

- **Socratic Gate**:
  - **New Features / Major Refactors**: Pose 2–3 strategic architecture, trade-off, or boundary questions before committing modifications.
  - **Direct "Proceed"**: Confirm critical edge cases before mutating files.

---

## 4. ENHANCED CODING PRINCIPLES
- **Defensive Engineering**:
  - **Null Safety**: Explicit assertions before property access.
  - **Input Validation**: Sanitize and validate external inputs at system boundaries.
  - **Resource Management**: Dispose listeners, clear timeouts, and close connections.
  - **State Integrity**: Assert invariants before persisting state mutations.
- **Architecture**:
  - Clean abstractions, dependency injection for testability, and decoupled services.
  - Standard directory layout: `src/`, `lib/` (utilities), `components/`, `services/`, `docs/`.
- **Documentation**:
  - Comprehensive JSDoc / docstrings for public APIs.
  - Inline rationale explaining the "why" behind non-obvious logic.
- **Production Standards**:
  - Mandatory loading states, graceful degradation, and resilient error boundaries.
