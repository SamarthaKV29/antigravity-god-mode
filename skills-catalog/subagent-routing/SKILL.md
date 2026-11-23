---
name: subagent-routing
description: Token-optimal subagent delegation protocol using built-in invoke_subagent across all 20 core antigravity-god-mode and 49 agency-agents specialists.
---

# Subagent Routing & Token-Budget Protocol

`invoke_subagent`, `send_message`, and `manage_subagents` are **built-in native Antigravity tools** (not external MCP servers). Use them deliberately so you maximize output quality while minimizing token waste.

## 1. Subagent vs. Inline Gate (Save Tokens First)
- **Stay Inline (0 subagent calls):** 1–2 file edits, simple bug fixes, quick `grep_search`/`read_file` lookups, or pure Q&A. Read a `skills-catalog/` skill inline instead of spawning a new agent context.
- **Auto-Invoke `invoke_subagent` when:**
  1. Deep specialist rigor materially improves output (security/AppSec audits, DB migrations, Stripe/RAG/multi-agent design, marketing/paid media/sales GTM, UX finish gates).
  2. Work splits cleanly into **parallel independent angles** (e.g., `security-auditor` + `test-engineer` running simultaneously).
  3. Fresh, unbiased review catches blind spots (`testing-reality-checker`, `design-ui-finish-gate-reviewer`).

## 2. Model Tiering (`Model` Parameter)
Always set `Model` intentionally instead of defaulting every call to heavy models:

| Tier | `Model` Value | Best For |
| :--- | :--- | :--- |
| **Economy** | `flash_lite` | Trivial extraction, formatting, mechanical transforms |
| **Fast / Lean** | `flash` | `explorer-agent` scans, marketing/sales/copy drafts, single-module audits, design walkthroughs |
| **Balanced** | `inherit` | Standard coding, debugging, TDD, frontend/backend/DB/AI implementation |
| **Deep / High-Stakes** | `pro` | Complex system architecture, threat modeling, security/AppSec, strict release gates |

## 3. Bounded Brief Rules (Zero Exploration Waste)
- **Pass exact paths & scope:** List exact file paths, line ranges, constraints, and desired output format in `Prompt` so the subagent skips repo-wide scanning.
- **Choose `Workspace` carefully:** Keep `inherit` (default) for readers/reviewers or sequential work; use `share` or `branch` **only** for parallel writers editing files concurrently.
- **Reuse before respawning:** Use `send_message` with the existing `conversationId` for follow-ups on the same task.
- **Wait reactively:** After invoking subagents, stop calling tools and wait for automatic wakeup—never poll in a loop.

## 4. Routing Directory (20 Core + 49 Agency Agents)

### Core Engineering (`plugins/antigravity-god-mode` — 20)
- **Architecture & Planning:** `orchestrator` (multi-domain coordination), `project-planner` (task/dependency breakdown), `explorer-agent` (fast read-only discovery), `code-archaeologist` (legacy reverse engineering)
- **Implementation:** `frontend-specialist`, `backend-specialist`, `database-architect`, `mobile-developer`, `game-developer`
- **Quality, Perf & Debug:** `debugger`, `test-engineer`, `qa-automation-engineer`, `performance-optimizer`
- **Security & Ops:** `security-auditor`, `penetration-tester`, `devops-engineer`
- **Product, SEO & Docs:** `product-manager`, `product-owner`, `seo-specialist`, `documentation-writer` *(only when docs explicitly requested)*

### Specialized Domains (`plugins/agency-agents` — 49)
- **AI, Payments, Desktop & AppSec (9):** `engineering-ai-engineer`, `engineering-rag-pipeline-engineer`, `engineering-prompt-engineer`, `engineering-multi-agent-systems-architect`, `engineering-payments-billing-engineer`, `engineering-desktop-app-engineer`, `engineering-voice-ai-integration-engineer`, `security-ai-generated-code-auditor`, `security-appsec-engineer`
- **Product & QA Gates (6):** `product-behavioral-nudge-engine`, `product-trend-researcher`, `product-feedback-synthesizer`, `testing-reality-checker`, `testing-evidence-collector`, `testing-test-automation-engineer`
- **Design & CRO (6):** `design-brand-guardian`, `design-visual-storyteller`, `design-image-prompt-engineer`, `design-whimsy-injector`, `design-persona-walkthrough`, `design-ui-finish-gate-reviewer`
- **Marketing & Growth (19):** `marketing-growth-hacker`, `marketing-social-media-strategist`, `marketing-content-creator`, `marketing-twitter-engager`, `marketing-x-twitter-intelligence-analyst`, `marketing-linkedin-content-creator`, `marketing-reddit-community-builder`, `marketing-developer-community-builder`, `marketing-video-optimization-specialist`, `marketing-tiktok-strategist`, `marketing-instagram-curator`, `marketing-carousel-growth-engine`, `marketing-short-video-editing-coach`, `marketing-email-strategist`, `marketing-app-store-optimizer`, `marketing-ai-citation-strategist`, `marketing-aeo-foundations`, `marketing-pr-communications-manager`, `marketing-global-podcast-strategist`
- **Paid Media & Sales (9):** `paid-media-ppc-strategist`, `paid-media-creative-strategist`, `paid-media-tracking-specialist`, `paid-media-paid-social-strategist`, `paid-media-auditor`, `sales-offer-lead-gen-strategist`, `sales-outbound-strategist`, `sales-discovery-coach`, `sales-proposal-strategist`
