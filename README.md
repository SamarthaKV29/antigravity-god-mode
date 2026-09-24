# antigravity-god-mode

**Centralized configuration hub, tiered skill catalog, and persona engine for Google Antigravity (AG 2.0) and Antigravity IDE.**

---

## 🚀 Overview

**antigravity-god-mode** provides a production-grade configuration architecture for Google Antigravity agents. It eliminates context-window bloat while delivering **120+ specialized domain skills**, **20 expert agent personas**, **23 workflows**, and strict defensive coding standards.

It is architected specifically for dual-environment workflows where **Antigravity 2.0 (Agent Manager / CLI)** and **Antigravity IDE** run side-by-side and share conversation history, project brains, and custom configurations through a unified symlink mesh.

```
                          ┌─────────────────────────────────────┐
                          │     ~/.gemini/config/ (Master)      │
                          │ agents/ · rules/ · global_workflows │
                          │ skills/ (active) · skills-catalog/  │
                          │ plugins/ · mcp_config.json          │
                          └──────────────────┬──────────────────┘
                                             │ (Symlinks)
                     ┌───────────────────────┴───────────────────────┐
                     ▼                                               ▼
       ┌───────────────────────────┐                   ┌───────────────────────────┐
       │   ~/.gemini/antigravity   │                   │ ~/.gemini/antigravity-ide │
       │     (AG 2.0 / Manager)    │                   │          (IDE)            │
       └─────────────┬─────────────┘                   └─────────────┬─────────────┘
                     │ (Symlinks)                                    │
                     └─────────────────► conversations/ ◄────────────┘
                                         brain/
                                         code_tracker/
```

---

## ⚡ Key Highlights

### 1. 🛡️ Context Protection via Tiered Skill Catalog
Standard Antigravity setups scan every folder in `skills/` on every user prompt, dumping thousands of tokens into the system prompt and triggering context exclusions. 

**antigravity-god-mode solves this with a two-tier architecture:**
- **Active Core Skills (`skills/`)**: Only 9 lean, universal meta-skills (`skill-picker`, `clean-code`, `concise-planning`, `debugger`, `architecture`, `api-design-principles`, `testing-patterns`, `error-handling-patterns`, `commit`) are active. System prompt overhead drops from >5,200 tokens to ~400 tokens.
- **Skill Catalog (`skills-catalog/`)**: 120+ specialized domain skills (Next.js, Flutter, Neon Postgres, FastAPI, Rust async, Tailwind v4, SEO, iOS, etc.) reside in the catalog.
- **Skill Picker Protocol**: The agent consults [`SKILL_INDEX.md`](skills-catalog/skill-picker/SKILL_INDEX.md) and reads specific `SKILL.md` files on-demand using `view_file`. Zero context waste.

### 2. 🔄 Shared Dual-Environment Architecture
- **Single Source of Truth**: All configurations live centrally in `~/.gemini/config/`.
- **Shared History & State**: `conversations/`, `brain/`, and `code_tracker/` are shared between `antigravity` and `antigravity-ide`, so you never lose conversation history or project memory when switching tools.
- **Relative Symlinks**: Portable, Git-friendly links that do not hardcode machine-specific paths.

### 3. 🎯 Unified Behavioral Rules (`GEMINI.md`)
- **Senior Engineer & Mentor Personas**: Balances deep technical rigor with concise, structured delivery.
- **Socratic Gate**: Proactively queries architectural trade-offs and edge cases on complex features before mutating code.
- **Defensive Engineering**: Null-safety assertions, input boundary validation, resource cleanup, and triple-checking multi-file edits.

---

## 📦 What's Inside

```
~/.gemini/config/
├── agents/             # 20 specialist personas (orchestrator, security-auditor, frontend-specialist, etc.)
├── global_workflows/   # 23 slash commands (/create, /deploy, /debug, /orchestrate, /test, etc.)
├── rules/              # Unified GEMINI.md behavioral directives
├── skills/             # 9 active core meta-skills (relative symlinks into skills-catalog/)
├── skills-catalog/     # 120+ domain skills organized by category + skill-picker index
├── plugins/            # Modular plugins (gemini-api, firebase, flutter, modern-web-guidance, etc.)
├── workflows/          # Workspace workflow generators
├── ARCHITECTURE.md     # In-depth architectural specification
├── README.md           # System guide & setup instructions
└── .gitignore          # Strict filter preventing secrets or local machine state from committing
```

### 🧩 Skill Catalog Categories

| Category | Skills Included |
| :--- | :--- |
| **Web & Frontend** | Next.js 14+ App Router, React best practices, Tailwind v4, Three.js, Zustand/Jotai, Web Performance |
| **Mobile & Cross-Platform** | Flutter & Dart 3, Native iOS (Swift/SwiftUI), React Native architecture, Mobile UX |
| **Backend & APIs** | FastAPI, Node.js microservices, NestJS, GraphQL architecture, REST API standards, Clerk Auth |
| **Databases & Storage** | PostgreSQL, Neon serverless, Prisma, Supabase automation, SQL optimization |
| **Systems, Shell & DevOps** | Rust async patterns, Linux/Bash automation, Monorepo management, Advanced Git workflows |
| **Testing & Quality** | TDD workflows, Vitest/Jest, Playwright/E2E, Defensive error-handling, Debugger |
| **SEO, Growth & Business** | Programmatic SEO, E-E-A-T authority building, Keyword strategy, A/B testing, Startup models |

---

## 🛠️ Quick Setup Guide

### Step 1: Clone into Centralized Config Store

```bash
git clone https://github.com/SamarthaKV29/antigravity-god-mode.git ~/.gemini/config
```

### Step 2: Establish Symlinks for AG 2.0 & AG IDE

Run the following commands to link both tools to your centralized config while preserving conversations:

```bash
# Antigravity 2.0 (CLI / Agent Manager)
mkdir -p ~/.gemini/antigravity
for item in agents rules skills workflows global_workflows plugins; do
  ln -sfn ~/.gemini/config/$item ~/.gemini/antigravity/$item
done

# Antigravity IDE
mkdir -p ~/.gemini/antigravity-ide
for item in agents rules skills workflows global_workflows plugins; do
  ln -sfn ~/.gemini/config/$item ~/.gemini/antigravity-ide/$item
done

# Share Conversations & Brain State between IDE and AG 2.0
mkdir -p ~/.gemini/antigravity-ide/conversations ~/.gemini/antigravity-ide/brain ~/.gemini/antigravity-ide/code_tracker
ln -sfn ~/.gemini/antigravity-ide/conversations ~/.gemini/antigravity/conversations
ln -sfn ~/.gemini/antigravity-ide/brain ~/.gemini/antigravity/brain
ln -sfn ~/.gemini/antigravity-ide/code_tracker ~/.gemini/antigravity/code_tracker
```

### Step 3: Run the Health Check Script

Use the built-in sync and integrity script to validate your environment:

```bash
chmod +x ~/.gemini/sync_antigravity.sh
~/.gemini/sync_antigravity.sh
```

---

## 🧭 How to Use the Skill Picker

When prompting your agent in Antigravity or Antigravity IDE:
1. **Universal Tasks**: Clean code, architecture design, testing patterns, and error handling are active automatically.
2. **Specialized Tasks**: When working with a specific stack (e.g. *"Build a serverless Neon Postgres backend with FastAPI"*), the agent references `skills-catalog/skill-picker/SKILL_INDEX.md` and loads:
   - `skills-catalog/using-neon/SKILL.md`
   - `skills-catalog/fastapi-pro/SKILL.md`
3. **Session Pinning (Optional)**: If you are doing an extended project entirely in one framework, you can temporarily pin that skill into `skills/`:
   ```bash
   ln -s ../skills-catalog/flutter-expert ~/.gemini/config/skills/flutter-expert
   ```
   To remove when finished:
   ```bash
   rm ~/.gemini/config/skills/flutter-expert
   ```

---

## 🔒 Security & Privacy

This repository is designed to be public-safe:
- Machine states (`installation_id`, `user_settings.pb`, `context_state/`) are ignored.
- Project metadata (`projects/`, `sidecars/`) and personal conversation histories (`conversations/`, `brain/`) are excluded.
- Credentials and tokens (`mcp_config.json`, `config.json`, `*.env`, `*.key`) are strictly blocked by [`.gitignore`](.gitignore).

---

## 🙌 Credits & Attributions

- **Antigravity Kit** (base architecture, personas, and workflows) by [@vudovn](https://github.com/vudovn)
- **Expanded Community Skills** by [@sickn33](https://github.com/sickn33)
- **Superdesign Engine** by [@superdesigndev](https://github.com/superdesigndev)
- **Curation, Tiered Skill Catalog & Dual-Sync Architecture** by [@SamarthaKV29](https://github.com/SamarthaKV29)

---

## 📜 License

See individual skill folders in `skills-catalog/` for respective open-source licenses.
