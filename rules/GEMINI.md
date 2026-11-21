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
  - **Null Safety**: Consistent null/undefined checks and explicit assertions before property access.
  - **Input Validation**: Comprehensive boundary validation and sanitization for all external inputs.
  - **Resource Management**: Robust disposal patterns and proactive memory management—dispose listeners, clear timeouts, and close connections.
  - **State Integrity**: Multi-checkpoint state verification; assert invariants before persisting state mutations.
- **Architecture & Async**:
  - **Service-Oriented & Decoupled**: Clean abstractions hiding complexity behind simple interfaces, dependency injection for testability, and event-driven message passing for loose coupling.
  - **Configurable & Cross-Platform**: Settings-driven behavior with intelligent, user-centric defaults (e.g., adjustable playback speed, retry attempts), universal cross-platform design principles, and consistent error handling.
  - **Async Mastery**: Disciplined asynchronous programming (especially in JavaScript) with comprehensive state management and error handling.
- **Code Organization & Style**:
  - **Directory Layout**: Structured separation of concerns (`src/`, `lib/` (utilities), `components/`, `services/`, `assets/`, `docs/`, plus dedicated `background/`, `content/`, `popups/`, `editors/`, `todos/` where applicable).
  - **Naming & Clarity**: Consistent, intent-revealing names (e.g., `validateJsonWithUserFeedback()` over `validate()`); self-explanatory "teaching code" structure with progressive complexity.
  - **Documentation**: First-class JSDoc/docstrings for public APIs, inline "why" rationale for non-obvious logic, structured API specs, clear READMEs, and user docs.
- **Performance & Caching**:
  - **Resource & Multitasking**: Cooperative multitasking and proactive resource/storage optimization.
  - **Multi-Tiered Caching**: Varying TTLs, DOM element caching, storage optimization, and proactive memory cleanup.
- **UX, Quality & Inclusion**:
  - **Resilient UI States**: Mandatory loading states/feedback, error recovery options, resilient error boundaries, graceful degradation, progressive enhancement, and visual overlays.
  - **Inclusive Standards**: Maintainable, scalable, reliable, security-conscious code with accessibility (ARIA labels), i18n readiness, and mobile-responsive design.

---

## 5. DELIVERY, OPS & STACK BASELINES
- **Quality Assurance**: Schema-driven development with structured data validation; reinforce testing with input validation, type safety, runtime assertions, and error boundaries.
- **Build, Versioning & Release**:
  - **Cross-Platform Builds**: Bash and PowerShell scripts with auto-detected versioning, environment awareness, color-coded output, and error recovery.
  - **Versioning & Lifecycle**: Semantic versioning with schema and fallback strategies, complete product delivery via automated release packaging, deployment automation, error monitoring, and release management.
- **Stack Baselines**:
  - **Chrome Extensions**: Manifest V3 compliance, cross-context messaging, minimized permissions, and optimized content scripts.
  - **Full-Stack Web**: Node.js/Express, React, database optimization, and RESTful APIs.
  - **DevOps & Security**: Flexible environment management, PM2 monitoring, zero-downtime deployments, rate limiting, and CORS.
