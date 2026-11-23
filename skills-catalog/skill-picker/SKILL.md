---
name: skill-picker
description: Dynamic on-demand skill finder and lazy loader. Consults the skill catalog in ~/.gemini/config/skills-catalog to fetch specialized domain instructions (Flutter, React, Next.js, Postgres, Neon, FastAPI, Rust, Tailwind, iOS, SEO, A/B testing, Clerk, etc.) without blowing context limits.
---

# Skill Picker (Lazy Skill Resolution Protocol)

## Purpose
To avoid blowing Google Antigravity's context window on every turn, only core meta-skills remain loaded in default context. All 120+ specialized domain skills reside in the centralized **Skill Catalog**:
`~/.gemini/config/skills-catalog/`

## Protocol

### 1. Identify Needed Domain Skill
When a user prompt or subtask requires deep domain guidance (e.g., Next.js App Router, Flutter, Rust async, Neon Postgres, Tailwind v4, SEO, Auth/Clerk):
1. Consult the index: [SKILL_INDEX.md](~/.gemini/config/skills-catalog/skill-picker/SKILL_INDEX.md)
2. Or locate the exact skill directory: `~/.gemini/config/skills-catalog/<skill-name>/SKILL.md`

### 2. Read On-Demand
Use `read_file` / `view_file` to read ONLY the specific skill's `SKILL.md` for the duration of that task.
Example:
`~/.gemini/config/skills-catalog/flutter-expert/SKILL.md`

### 3. Session Activation (Optional)
If a user indicates an entire project or extended session will focus on a specific stack (e.g., full Flutter project):
Link that skill from the catalog into `~/.gemini/config/skills/<skill-name>`:

**macOS / Linux:**
```bash
ln -s ~/.gemini/config/skills-catalog/<skill-name> ~/.gemini/config/skills/<skill-name>
# Deactivate after completion:
rm ~/.gemini/config/skills/<skill-name>
```

**Windows (PowerShell):**
```powershell
New-Item -ItemType Junction -Path "$HOME\.gemini\config\skills\<skill-name>" -Target "$HOME\.gemini\config\skills-catalog\<skill-name>"
# Deactivate after completion:
Remove-Item "$HOME\.gemini\config\skills\<skill-name>"
```

### 4. Direct Catalog Lookup Table
- **Next.js / React Web**: [nextjs-app-router-patterns](~/.gemini/config/skills-catalog/nextjs-app-router-patterns/SKILL.md), [react-best-practices](~/.gemini/config/skills-catalog/react-best-practices/SKILL.md), [react-state-management](~/.gemini/config/skills-catalog/react-state-management/SKILL.md)
- **Styling**: [tailwind-design-system](~/.gemini/config/skills-catalog/tailwind-design-system/SKILL.md), [ui-ux-pro-max](~/.gemini/config/skills-catalog/ui-ux-pro-max/SKILL.md)
- **Mobile**: [flutter-expert](~/.gemini/config/skills-catalog/flutter-expert/SKILL.md), [ios-developer](~/.gemini/config/skills-catalog/ios-developer/SKILL.md), [react-native-architecture](~/.gemini/config/skills-catalog/react-native-architecture/SKILL.md)
- **Backend / Python / Node**: [fastapi-pro](~/.gemini/config/skills-catalog/fastapi-pro/SKILL.md), [nodejs-backend-patterns](~/.gemini/config/skills-catalog/nodejs-backend-patterns/SKILL.md), [graphql-architect](~/.gemini/config/skills-catalog/graphql-architect/SKILL.md)
- **Databases**: [postgres-best-practices](~/.gemini/config/skills-catalog/postgres-best-practices/SKILL.md), [using-neon](~/.gemini/config/skills-catalog/using-neon/SKILL.md), [prisma-expert](~/.gemini/config/skills-catalog/prisma-expert/SKILL.md), [supabase-automation](~/.gemini/config/skills-catalog/supabase-automation/SKILL.md)
- **Systems & Shell**: [rust-pro](~/.gemini/config/skills-catalog/rust-pro/SKILL.md), [bash-pro](~/.gemini/config/skills-catalog/bash-pro/SKILL.md), [git-advanced-workflows](~/.gemini/config/skills-catalog/git-advanced-workflows/SKILL.md)
- **Auth**: [clerk-auth](~/.gemini/config/skills-catalog/clerk-auth/SKILL.md), [auth-implementation-patterns](~/.gemini/config/skills-catalog/auth-implementation-patterns/SKILL.md)
- **SEO & Growth**: [seo-fundamentals](~/.gemini/config/skills-catalog/seo-fundamentals/SKILL.md), [ab-test-setup](~/.gemini/config/skills-catalog/ab-test-setup/SKILL.md)
