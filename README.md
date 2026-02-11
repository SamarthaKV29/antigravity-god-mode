# antigravity-god-mode

**Drop-in skill pack that turns any AI coding agent into a full engineering team.**

---

## 🚀 What is this?

A single folder you place inside your AI agent's config directory. Once loaded, your agent gains access to **~660 specialized skills**, **20 expert personas**, and **16 workflow commands** — covering everything from React patterns to penetration testing to Zoom automation.

No config files to write. No plugins to install. Just copy the folders and go.

```
git clone https://github.com/SamarthaKV29/antigravity-god-mode.git
cp -r antigravity-god-mode/* ~/.gemini/antigravity/.
```

## 🧠 Why?

AI coding agents are powerful out of the box, but they're generalists. They know a little about everything and a lot about nothing specific. That means you spend half your time re-explaining conventions, pasting documentation, and correcting hallucinated API calls.

**antigravity-god-mode** fixes this by giving your agent deep, structured knowledge across 25+ domains — the same way a senior engineer builds expertise over years, except it loads in seconds.

## 📦 What's inside

```
agents/     → 20 specialist personas (security auditor, database architect, etc.)
skills/     → ~660 domain modules (React, Terraform, XSS testing, Wrike automation, etc.)
workflows/  → 16 slash commands (/deploy, /debug, /orchestrate, /test, etc.)
rules/      → Global behavior rules
scripts/    → Validation and verification scripts
```

### 🧩 Skill categories at a glance

| Category | Examples | Count |
|----------|----------|-------|
| Frontend & UI | React, Next.js, Vue, Tailwind, Radix UI | ~30 |
| Backend & API | Node.js, FastAPI, NestJS, GraphQL, Go | ~25 |
| Security & Pentesting | OWASP, XSS, SQLi, Burp Suite, Metasploit | ~30 |
| SaaS Automation | Slack, Jira, Zendesk, Salesforce, Zoom, Wrike | ~30 |
| Cloud & Infra | Docker, K8s, Terraform, AWS, GCP, Azure | ~25 |
| AI & ML | RAG, LangChain, LangGraph, prompt engineering | ~20 |
| Testing & Quality | Jest, Playwright, TDD, code review | ~20 |
| Database | PostgreSQL, Prisma, NoSQL, migrations | ~15 |
| Mobile | Flutter, React Native, SwiftUI, iOS | ~8 |
| SEO & Growth | Technical SEO, content strategy, ASO | ~15 |
| Content & Docs | Excel, PDF, PowerPoint, YouTube summaries | ~10 |
| And more... | Game dev, shell scripting, 15+ languages | ~400+ |

### 🛠️ Workflows

Type a slash command and the agent handles the rest:

- ✨ `/create` — scaffold a new app with the right agents
- 🧪 `/debug` — systematic root cause analysis
- 🚢 `/deploy` — pre-flight checks → build → deploy → verify
- 🧠 `/orchestrate` — coordinate 3+ specialist agents on complex tasks
- ✅ `/test` — generate and run tests with coverage
- 🗺️ `/plan` — break down a project before writing code
- 💡 `/brainstorm` — explore 3+ options with tradeoffs before committing

[Full list in ARCHITECTURE.md](ARCHITECTURE.md)

## ⚡ Quick start

1. Copy this folder into your agent's config directory (e.g. `~/.gemini/`, `~/.claude/`, or your project's `.agent/`)
2. That's it. Your agent now has god mode.

## 🧭 How it works

When your agent receives a task, it matches the request against skill descriptions and loads the relevant knowledge on demand. A React question pulls in `react-patterns` and `react-best-practices`. A security audit loads `vulnerability-scanner`, `xss-html-injection`, and `pentest-checklist`. The agent stays lean until it needs to be deep.

Skills are composable — agents combine multiple skills for complex tasks. The `orchestrator` agent can coordinate `frontend-specialist`, `backend-specialist`, and `test-engineer` in parallel to build a full feature end-to-end.

## � Rules & Behavior

The `rules/` directory contains global behavior configurations that govern how agents operate:

- **GEMINI.md** — Core protocol for Google Gemini agents
  - 3-tier rule hierarchy (Universal → Code → Design)
  - Socratic Gate: mandatory clarification questions before implementation
  - Agent routing and skill loading protocol
  - Production-readiness checklists
  - Verification script execution standards

Rules define:
- **When** agents ask questions vs. proceed directly
- **How** skills are loaded on-demand
- **Which** verification scripts run at each stage
- **What** production standards must be met

This ensures consistent behavior across all agents — whether you're debugging, deploying, or designing.

## �👥 Who is this for

- Engineers who use AI coding agents daily and want fewer corrections
- Teams standardizing how their AI agents approach architecture, testing, and security
- Anyone tired of re-pasting the same documentation into every conversation

## 🙌 Credits

This project is a curated assembly — not built from scratch. The workflows and configuration are original, but the skills and foundational kit come from these creators:

| What | Who | Repo |
|------|-----|------|
| **Antigravity Kit** (base agents, core skills, scripts) | [@vudovn](https://github.com/vudovn) | [antigravity-kit](https://github.com/vudovn/antigravity-kit) |
| **~600 expanded skills** (SaaS automation, security, AI/ML, and more) | [@sickn33](https://github.com/sickn33) | [antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) |
| **Superdesign skill** (UI/UX design workflow via CLI) | [@superdesigndev](https://github.com/superdesigndev) | [superdesign-skill](https://github.com/superdesigndev/superdesign-skill) |

My contribution is the curation: merging these sources into a single working setup, writing the workflows, and maintaining a config that works out of the box for most Antigravity users.

## 📜 License

See individual skill directories for licensing. Community-contributed skills retain their original licenses.
