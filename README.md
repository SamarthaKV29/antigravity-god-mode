<div align="center">

# ⚡ antigravity-god-mode

**Lean, cross-platform configuration hub for Google Antigravity (AG 2.0) and Antigravity IDE.**  
*Maximum capability. Minimal token waste. Zero-friction dual-environment sync.*

[![GitHub Stars](https://img.shields.io/github/stars/SamarthaKV29/antigravity-god-mode?style=flat-square&logo=github)](https://github.com/SamarthaKV29/antigravity-god-mode/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](CONTRIBUTING.md)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-Support-FFDD00?style=flat-square&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/sxjcrbcpnv)

</div>

---

## ✨ Why antigravity-god-mode?

Default agent setups load every skill and persona into every turn, burning thousands of tokens before you even write a line of code. **antigravity-god-mode** keeps your baseline prompt razor-thin while giving Antigravity instant access to a complete engineering & growth stack:

| Layer | Count | Per-Turn Overhead | How It Loads |
| :--- | :---: | :---: | :--- |
| **Core Meta-Skills (`skills/`)** | **10** | **~576 tokens** | Real cross-platform directories; frontmatter only until triggered |
| **Domain Skill Catalog (`skills-catalog/`)** | **131** | **0 tokens** | On-demand lookup via [`SKILL_INDEX.md`](skills-catalog/skill-picker/SKILL_INDEX.md) |
| **Core Engineering Subagents (`plugins/antigravity-god-mode`)** | **20** | **~452 tokens** | Native `invoke_subagent` with compact 1-line routing headers |
| **Curated Agency Subagents (`plugins/agency-agents`)** | **49** | **~1,214 tokens** | Optional toggleable plugin for Marketing, Paid Media, Sales, Design, QA & AI/AppSec |
| **Workflows (`global_workflows/` + `workflows/`)** | **22** | **0 tokens** | Triggered explicitly via `/command` (`21` global + `1` workspace) |

---

## 🏗️ Architecture

All configurations live in `~/.gemini/config/` (Antigravity's native global discovery directory). If you run both **Antigravity 2.0** and **Antigravity IDE** side by side, you can optionally pass `-LinkIde` (Windows) or `--link-ide` (macOS/Linux) (**USE CAUTION**) to share history & configs:

```text
~/.gemini/config/                      # Single Source of Truth
├── rules/GEMINI.md                    # Unified rules, Socratic Gate & token-budget routing
├── skills/                            # 10 active core skills (real directories, Windows-safe)
├── skills-catalog/                    # 131 on-demand skills + skill-picker/SKILL_INDEX.md
├── plugins/
│   ├── antigravity-god-mode/          # 20 core engineering subagents (subagent: true)
│   └── agency-agents/                 # 49 curated domain subagents (MIT)
├── global_workflows/                  # 21 slash commands (/create, /debug, /deploy, /test, ...)
├── workflows/                         # 1 workspace generator (generate-context)
├── setup.ps1                          # Windows 1-step non-destructive installer & updater
└── setup.sh                           # macOS / Linux 1-step non-destructive installer & updater
```

> [!IMPORTANT]
> **Why Windows Doesn't Use Symlinks Here:** Standard symlinks fail on Windows unless Developer Mode or Administrator privileges are enabled (which breaks Git POSIX symlinks after cloning). To work cleanly out of the box:
> - `skills/` uses **real directories** (no symlinks required on any OS).
> - Optional IDE linking & skill pinning on Windows use **NTFS Directory Junctions** (`New-Item -ItemType Junction`), which work for any standard user without Admin or Developer Mode (macOS/Linux use standard symlinks).

---

## 🛠️ One-Step Non-Destructive Setup

> [!NOTE]
> **Safe by Default — Your Existing Setup Is Never Wiped:**
> - **Fresh machine:** Installs cleanly into `~/.gemini/config/`.
> - **Existing setup:** Adds **only new/missing files**. Your custom `GEMINI.md` edits, `config.json`, `mcp_config.json`, custom skills, and Marketplace plugins remain untouched.
> - **Updating later:** Pass `-Update` (Windows) or `--update` (macOS/Linux) to update repo-managed files—modified local files are backed up as `*.bak.<timestamp>` first.
> - **Optional dual-IDE sync:** `~/.gemini/config/` already works natively without linking. Pass `-LinkIde` (Windows Junctions) or `--link-ide` (macOS/Linux symlinks) only if you also want to link `~/.gemini/antigravity` & `~/.gemini/antigravity-ide` (plus share `conversations/`, `brain/`, and `code_tracker/`).

### Option A: One-Step Remote Install

Please be sure to close all instances of Antigravity before running the script. In macos, right click on the icon in the dock and click quit.

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/SamarthaKV29/antigravity-god-mode/main/setup.ps1 | iex
```

**macOS / Linux (Bash):**
```bash
curl -fsSL https://raw.githubusercontent.com/SamarthaKV29/antigravity-god-mode/main/setup.sh | bash
```

### Option B: Clone & Run Locally (Contributors)

**Windows (PowerShell):**
```powershell
git clone https://github.com/SamarthaKV29/antigravity-god-mode.git
cd antigravity-god-mode
.\setup.ps1            # Safe additive install into ~/.gemini/config (missing items only)
.\setup.ps1 -Update    # Optional: refresh repo files (creates .bak backups)
.\setup.ps1 -LinkIde   # Optional: link antigravity & antigravity-ide via Windows Junctions
```

**macOS / Linux (Bash):**
```bash
git clone https://github.com/SamarthaKV29/antigravity-god-mode.git
cd antigravity-god-mode && chmod +x setup.sh
./setup.sh             # Safe additive install into ~/.gemini/config (missing items only)
./setup.sh --update    # Optional: refresh repo files (creates .bak backups)
./setup.sh --link-ide  # Optional: link antigravity & antigravity-ide via symlinks
```

---

## 🤖 Subagents & Token Optimization

- **Automatic Routing ([`GEMINI.md`](rules/GEMINI.md) + [`subagent-routing`](skills/subagent-routing/SKILL.md)):** Simple 1–2 file edits stay inline (`0` extra contexts), while specialized tasks auto-invoke `invoke_subagent` with explicit `Model` tiering (`flash` / `flash_lite` for discovery & copy, `inherit` for coding, `pro` for security & release gates) and bounded file paths.
- **20 Core Subagents (`antigravity-god-mode`):** `orchestrator`, `project-planner`, `explorer-agent`, `code-archaeologist`, `frontend-specialist`, `backend-specialist`, `database-architect`, `mobile-developer`, `game-developer`, `debugger`, `test-engineer`, `qa-automation-engineer`, `performance-optimizer`, `security-auditor`, `penetration-tester`, `devops-engineer`, `product-manager`, `product-owner`, `seo-specialist`, `documentation-writer`.
- **49 Curated Subagents (`agency-agents`):** Marketing & AEO/GEO (`19`), Paid Media & Sales GTM (`9`), Brand/Story/UI Gate Design (`6`), Product & QA Release Gates (`6`), AI/RAG/Payments/Desktop/AppSec (`9`). Toggle anytime in Antigravity Customizations.

---

## 🧭 Skill Catalog (`131` On-Demand Skills)

| Category | Highlights |
| :--- | :--- |
| **Web & Frontend** | Next.js App Router, React, Tailwind v4, TypeScript, Three.js, Web Performance |
| **Mobile** | Flutter & Dart 3, Native iOS (Swift/SwiftUI), React Native |
| **Backend & APIs** | FastAPI, Node.js, NestJS, GraphQL, REST standards, Clerk Auth |
| **Databases** | PostgreSQL, Neon serverless, Prisma, Supabase |
| **Systems & DevOps** | Rust async, Bash, PowerShell, Monorepos, Git workflows |
| **Testing & Quality** | TDD, Jest/Vitest, E2E testing, Defensive error handling, `subagent-routing` |
| **SEO & Business** | Programmatic SEO, E-E-A-T, A/B testing, Startup financial modeling |

To temporarily pin any catalog skill into `skills/` for an extended single-stack project:
```powershell
# Windows (PowerShell)
New-Item -ItemType Junction -Path "$HOME\.gemini\config\skills\flutter-expert" -Target "$HOME\.gemini\config\skills-catalog\flutter-expert"
```
```bash
# macOS / Linux
ln -s ~/.gemini/config/skills-catalog/flutter-expert ~/.gemini/config/skills/flutter-expert
```

---

## 🤝 Contributing & Support

Contributions make this project better for the whole Antigravity community!
- Read [CONTRIBUTING.md](CONTRIBUTING.md) and our [Code of Conduct](CODE_OF_CONDUCT.md) before opening a PR.
- Found a bug or want to request a skill/subagent? [Open an Issue](https://github.com/SamarthaKV29/antigravity-god-mode/issues).
- If this setup saves you time and tokens, consider starring the repo ⭐ or supporting development:

<a href="https://buymeacoffee.com/sxjcrbcpnv" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="40"></a>

---

## 🔒 Security, Credits & License

- **Public-Safe [`.gitignore`](.gitignore):** Blocks credentials, `config.json`, `mcp_config.json`, tokens, runtime state, and personal chat histories.
- **Special Thanks & Credits:**
  - **Antigravity Kit** (base architecture, personas, and workflows) by [@vudovn](https://github.com/vudovn)
  - **[agency-agents](https://github.com/msitarzewski/agency-agents)** (49 curated specialist subagents, MIT) by [@msitarzewski](https://github.com/msitarzewski) & contributors
  - **Expanded Community Skills** by [@sickn33](https://github.com/sickn33)
  - **Superdesign Engine** by [@superdesigndev](https://github.com/superdesigndev)
  - **Curation, Tiered Skill Catalog & Dual-Sync Architecture** by [@SamarthaKV29](https://github.com/SamarthaKV29)
- **License:** Released under the [MIT License](LICENSE). Third-party skills and agents retain their original open-source licenses.
