# Antigravity Kit Architecture

> Comprehensive AI Agent Capability Expansion Toolkit

---

## 📋 Overview

Antigravity Kit is a modular system consisting of:

- **20 Specialist Agents** - Role-based AI personas
- **~660 Skills** - Domain-specific knowledge modules across 25+ categories
- **16 Workflows** - Slash command procedures

---

## 🏗️ Directory Structure

```plaintext
.agent/
├── ARCHITECTURE.md          # This file
├── agents/                  # 20 Specialist Agents
├── skills/                  # ~660 Skills
├── workflows/               # 16 Slash Commands
├── rules/                   # Global Rules
└── scripts/                 # Master Validation Scripts
```

---

## 🤖 Agents (20)

Specialist AI personas for different domains.

| Agent | Focus | Skills Used |
| ----- | ----- | ----------- |
| `orchestrator` | Multi-agent coordination | parallel-agents, behavioral-modes |
| `project-planner` | Discovery, task planning | brainstorming, plan-writing, architecture |
| `frontend-specialist` | Web UI/UX | frontend-design, react-patterns, tailwind-patterns |
| `backend-specialist` | API, business logic | api-patterns, nodejs-best-practices, database-design |
| `database-architect` | Schema, SQL | database-design, prisma-expert |
| `mobile-developer` | iOS, Android, RN | mobile-design |
| `game-developer` | Game logic, mechanics | game-development |
| `devops-engineer` | CI/CD, Docker | deployment-procedures, docker-expert |
| `security-auditor` | Security compliance | vulnerability-scanner, red-team-tactics |
| `penetration-tester` | Offensive security | red-team-tactics |
| `test-engineer` | Testing strategies | testing-patterns, tdd-workflow, webapp-testing |
| `debugger` | Root cause analysis | systematic-debugging |
| `performance-optimizer` | Speed, Web Vitals | performance-profiling |
| `seo-specialist` | Ranking, visibility | seo-fundamentals, geo-fundamentals |
| `documentation-writer` | Manuals, docs | documentation-templates |
| `product-manager` | Requirements, user stories | plan-writing, brainstorming |
| `product-owner` | Strategy, backlog, MVP | plan-writing, brainstorming |
| `qa-automation-engineer` | E2E testing, CI pipelines | webapp-testing, testing-patterns |
| `code-archaeologist` | Legacy code, refactoring | clean-code, code-review-checklist |
| `explorer-agent` | Codebase analysis | - |

---

## 🧩 Skills (~660)

Modular knowledge domains that agents can load on-demand based on task context. Organized into 25+ categories spanning the full software development lifecycle, SaaS automation, security testing, and content generation.

### Frontend & UI (~30 skills)

| Skill | Description |
| ----- | ----------- |
| `react-patterns` | React hooks, state, performance |
| `react-best-practices` | Modern React patterns |
| `react-state-management` | State strategies (Context, Zustand, etc.) |
| `nextjs-best-practices` | App Router, Server Components |
| `nextjs-app-router-patterns` | App Router advanced patterns |
| `tailwind-patterns` | Tailwind CSS v4 utilities |
| `tailwind-design-system` | Design system with Tailwind |
| `angular`, `vue`, `svelte` | Framework-specific patterns |
| `ui-ux-pro-max` | 50 styles, 97 palettes, 57 fonts |
| `radix-ui-design-system` | Radix UI component patterns |
| `stitch-ui-design` | Stitch UI design system |

### Backend & API (~25 skills)

| Skill | Description |
| ----- | ----------- |
| `api-patterns` | REST, GraphQL, tRPC |
| `api-design-principles` | API design best practices |
| `nestjs-expert` | NestJS modules, DI, decorators |
| `nodejs-best-practices` | Node.js async, modules |
| `python-patterns` | Python standards, FastAPI |
| `fastapi-pro` | FastAPI templates and patterns |
| `django-pro` | Django best practices |
| `golang-pro` | Go patterns and concurrency |
| `graphql-architect` | GraphQL schema design |
| `microservices-patterns` | Microservices architecture |

### Database (~15 skills)

| Skill | Description |
| ----- | ----------- |
| `database-design` | Schema design, optimization |
| `prisma-expert` | Prisma ORM, migrations |
| `postgresql` | PostgreSQL patterns |
| `postgres-best-practices` | PostgreSQL optimization |
| `nosql-expert` | NoSQL database patterns |
| `database-migration` | Migration strategies |
| `sql-optimization-patterns` | SQL query optimization |
| `neon-postgres` | Neon serverless Postgres |

### TypeScript/JavaScript (~10 skills)

| Skill | Description |
| ----- | ----------- |
| `typescript-expert` | Type-level programming, performance |
| `typescript-pro` | Advanced TypeScript patterns |
| `typescript-advanced-types` | Complex type utilities |
| `javascript-pro` | Modern JavaScript patterns |
| `javascript-mastery` | Advanced JS techniques |

### Cloud & Infrastructure (~25 skills)

| Skill | Description |
| ----- | ----------- |
| `docker-expert` | Containerization, Compose |
| `kubernetes-architect` | K8s architecture |
| `terraform-specialist` | Terraform IaC |
| `aws-serverless` | AWS Lambda, API Gateway |
| `gcp-cloud-run` | Google Cloud Run |
| `azure-functions` | Azure serverless |
| `deployment-procedures` | CI/CD, deploy workflows |
| `server-management` | Infrastructure management |
| `helm-chart-scaffolding` | Kubernetes Helm charts |
| `istio-traffic-management` | Service mesh traffic |

### Testing & Quality (~20 skills)

| Skill | Description |
| ----- | ----------- |
| `testing-patterns` | Jest, Vitest, strategies |
| `webapp-testing` | E2E, Playwright |
| `tdd-workflow` | Test-driven development |
| `tdd-orchestrator` | TDD coordination |
| `playwright-skill` | Playwright E2E testing |
| `code-review-checklist` | Code review standards |
| `lint-and-validate` | Linting, validation |
| `e2e-testing-patterns` | End-to-end testing |
| `python-testing-patterns` | Python test strategies |
| `javascript-testing-patterns` | JS test strategies |

### Security & Pentesting (~30 skills)

| Skill | Description |
| ----- | ----------- |
| `vulnerability-scanner` | Security auditing, OWASP |
| `red-team-tactics` | Offensive security |
| `xss-html-injection` | XSS and HTML injection testing |
| `sql-injection-testing` | SQL injection detection |
| `api-fuzzing-bug-bounty` | API fuzzing techniques |
| `pentest-checklist` | Penetration testing checklists |
| `aws-penetration-testing` | AWS-specific pentesting |
| `burp-suite-testing` | Burp Suite workflows |
| `metasploit-framework` | Metasploit usage |
| `secrets-management` | Secrets handling best practices |

### SaaS Automation via Rube MCP (~30 skills)

Automate third-party SaaS tools through Composio's toolkit via Rube MCP.

| Skill | Description |
| ----- | ----------- |
| `wrike-automation` | Wrike project management |
| `zendesk-automation` | Zendesk ticket management |
| `zoho-crm-automation` | Zoho CRM records and leads |
| `zoom-automation` | Zoom meetings and recordings |
| `youtube-automation` | YouTube video and playlist management |
| `slack-automation` | Slack messaging and channels |
| `jira-automation` | Jira issue tracking |
| `github-automation` | GitHub repos and PRs |
| `salesforce-automation` | Salesforce CRM |
| `hubspot-automation` | HubSpot marketing/CRM |
| `airtable-automation` | Airtable bases and records |
| `notion-automation` | Notion pages and databases |
| `stripe-automation` | Stripe payments |
| `linear-automation` | Linear issue tracking |
| `clickup-automation` | ClickUp task management |
| `trello-automation` | Trello boards and cards |

### Content & Document Generation (~10 skills)

| Skill | Description |
| ----- | ----------- |
| `xlsx-official` | Excel creation, formulas, formatting |
| `docx-official` | Word document generation |
| `pdf-official` | PDF document generation |
| `pptx-official` | PowerPoint generation |
| `youtube-summarizer` | YouTube transcript extraction and summarization |
| `x-article-publisher-skill` | Publish articles to X/Twitter |

### Architecture & Planning (~15 skills)

| Skill | Description |
| ----- | ----------- |
| `app-builder` | Full-stack app scaffolding |
| `architecture` | System design patterns |
| `architecture-patterns` | Architecture decision patterns |
| `plan-writing` | Task planning, breakdown |
| `brainstorming` | Socratic questioning |
| `workflow-patterns` | TDD workflow, phase checkpoints, git commits |
| `conductor-setup` | Project context initialization |
| `conductor-implement` | Task implementation via Conductor |
| `context-driven-development` | Context artifact management |

### Mobile (~8 skills)

| Skill | Description |
| ----- | ----------- |
| `mobile-design` | Mobile UI/UX patterns |
| `flutter-expert` | Flutter widget patterns |
| `react-native-architecture` | React Native architecture |
| `swiftui-expert-skill` | SwiftUI development |
| `ios-developer` | iOS development patterns |
| `expo-deployment` | Expo deployment workflows |

### Game Development (~5 skills)

| Skill | Description |
| ----- | ----------- |
| `game-development` | Game logic, mechanics |
| `unity-developer` | Unity game development |
| `unity-ecs-patterns` | Unity ECS architecture |
| `godot-gdscript-patterns` | Godot GDScript |
| `unreal-engine-cpp-pro` | Unreal Engine C++ |

### SEO & Growth (~15 skills)

| Skill | Description |
| ----- | ----------- |
| `seo-fundamentals` | SEO, E-E-A-T, Core Web Vitals |
| `geo-fundamentals` | GenAI optimization |
| `seo-content-writer` | SEO-optimized content |
| `seo-keyword-strategist` | Keyword research |
| `seo-structure-architect` | Site structure for SEO |
| `programmatic-seo` | Programmatic SEO at scale |
| `app-store-optimization` | Mobile app store SEO |

### AI & ML (~20 skills)

| Skill | Description |
| ----- | ----------- |
| `ai-engineer` | AI engineering patterns |
| `rag-engineer` | RAG implementation |
| `langchain-architecture` | LangChain patterns |
| `langgraph` | LangGraph agent workflows |
| `prompt-engineering` | Prompt design |
| `llm-evaluation` | LLM evaluation frameworks |
| `vector-database-engineer` | Vector DB patterns |
| `computer-vision-expert` | CV pipelines |
| `voice-ai-development` | Voice AI systems |

### No-Code Automation (~5 skills)

| Skill | Description |
| ----- | ----------- |
| `zapier-make-patterns` | Zapier and Make automation |
| `n8n-mcp-tools-expert` | n8n workflow automation |
| `workflow-automation` | General workflow automation |

### Shell/CLI (~6 skills)

| Skill | Description |
| ----- | ----------- |
| `bash-linux` | Linux commands, scripting |
| `bash-pro` | Advanced bash patterns |
| `powershell-windows` | Windows PowerShell |
| `posix-shell-pro` | POSIX shell scripting |
| `linux-shell-scripting` | Linux shell automation |

### Multi-Language Support (~15 skills)

| Skill | Description |
| ----- | ----------- |
| `rust-pro` | Rust systems programming |
| `c-pro` / `cpp-pro` | C/C++ patterns |
| `java-pro` | Java patterns |
| `csharp-pro` | C# patterns |
| `ruby-pro` | Ruby patterns |
| `elixir-pro` | Elixir patterns |
| `scala-pro` | Scala patterns |
| `haskell-pro` | Haskell patterns |
| `php-pro` | PHP patterns |

### Core / Cross-Cutting

| Skill | Description |
| ----- | ----------- |
| `clean-code` | Coding standards (Global) |
| `behavioral-modes` | Agent personas |
| `parallel-agents` | Multi-agent patterns |
| `documentation-templates` | Doc formats |
| `i18n-localization` | Internationalization |
| `performance-profiling` | Web Vitals, optimization |
| `systematic-debugging` | Troubleshooting |

---

## 🔄 Workflows (16)

Slash command procedures. Invoke with `/command`.

| Command | Description |
| ------- | ----------- |
| `/brainstorm` | Socratic discovery, 3+ options with tradeoffs |
| `/conductor` | Project context management (setup, scan, validate) |
| `/create` | Create new applications via agent orchestration |
| `/debug` | Systematic problem investigation |
| `/deploy` | Production deployment with pre-flight checks |
| `/enhance` | Iterative feature additions to existing apps |
| `/fal` | Route fal.ai requests (generate, upscale, edit, audio) |
| `/nextjs` | Build or enhance Next.js App Router applications |
| `/orchestrate` | Multi-agent coordination (min 3 agents) |
| `/plan` | Project planning with dynamic naming |
| `/preview` | Preview server start/stop/status |
| `/react-spa` | Build or enhance React SPA applications |
| `/status` | Display agent and project status board |
| `/superdesign` | UI/UX design workflow via superdesign CLI |
| `/test` | Test generation, execution, and coverage |
| `/ui-ux-pro-max` | Design with 50+ styles, 97 palettes, 57 fonts |

---

## 🎯 Skill Loading Protocol

```plaintext
User Request → Skill Description Match → Load SKILL.md
                                            ↓
                                    Read references/
                                            ↓
                                    Read scripts/
```

### Skill Structure

```plaintext
skill-name/
├── SKILL.md           # (Required) Metadata & instructions
├── scripts/           # (Optional) Python/Bash scripts
├── references/        # (Optional) Templates, docs
└── assets/            # (Optional) Images, logos
```

### Enhanced Skills (with scripts/references)

| Skill | Files | Coverage |
| ----- | ----- | -------- |
| `typescript-expert` | 5 | Utility types, tsconfig, cheatsheet |
| `ui-ux-pro-max` | 27 | 50 styles, 21 palettes, 50 fonts |
| `app-builder` | 20 | Full-stack scaffolding |

---

## � Scripts (2)

Master validation scripts that orchestrate skill-level scripts.

### Master Scripts

| Script | Purpose | When to Use |
| ------ | ------- | ----------- |
| `checklist.py` | Priority-based validation (Core checks) | Development, pre-commit |
| `verify_all.py` | Comprehensive verification (All checks) | Pre-deployment, releases |

### Usage

```bash
# Quick validation during development
python .agent/scripts/checklist.py .

# Full verification before deployment
python .agent/scripts/verify_all.py . --url http://localhost:3000
```

### What They Check

**checklist.py** (Core checks):

- Security (vulnerabilities, secrets)
- Code Quality (lint, types)
- Schema Validation
- Test Suite
- UX Audit
- SEO Check

**verify_all.py** (Full suite):

- Everything in checklist.py PLUS:
- Lighthouse (Core Web Vitals)
- Playwright E2E
- Bundle Analysis
- Mobile Audit
- i18n Check

For details, see [scripts/README.md](scripts/README.md)

---

## 📊 Statistics

| Metric | Value |
| ------ | ----- |
| **Total Agents** | 20 |
| **Total Skills** | ~660 |
| **Total Workflows** | 16 |
| **Total Scripts** | 2 (master) + 18 (skill-level) |
| **Coverage** | Full-stack dev, DevOps, Security, AI/ML, SaaS automation, Content generation |

*Last updated: 2026-02-11*

---

## 🔗 Quick Reference

| Need | Agent | Skills |
| ---- | ----- | ------ |
| Web App | `frontend-specialist` | react-patterns, nextjs-best-practices |
| API | `backend-specialist` | api-patterns, nodejs-best-practices |
| Mobile | `mobile-developer` | mobile-design, flutter-expert |
| Database | `database-architect` | database-design, prisma-expert |
| Security | `security-auditor` | vulnerability-scanner, xss-html-injection |
| Testing | `test-engineer` | testing-patterns, webapp-testing |
| Debug | `debugger` | systematic-debugging |
| Plan | `project-planner` | brainstorming, plan-writing |
| SaaS Ops | `orchestrator` | wrike-automation, zendesk-automation |
| Content | `documentation-writer` | xlsx-official, youtube-summarizer |
| AI/ML | `backend-specialist` | rag-engineer, langchain-architecture |
