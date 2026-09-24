---
name: skill-picker
description: Dynamic on-demand skill finder and lazy loader. Consults the skill catalog in /Users/sam/.gemini/config/skills-catalog to fetch specialized domain instructions (Flutter, React, Next.js, Postgres, Neon, FastAPI, Rust, Tailwind, iOS, SEO, A/B testing, Clerk, etc.) without blowing context limits.
---

# Skill Picker (Lazy Skill Resolution Protocol)

## Purpose
To avoid blowing Google Antigravity's context window on every turn, only core meta-skills remain loaded in default context. All 120+ specialized domain skills reside in the centralized **Skill Catalog**:
`/Users/sam/.gemini/config/skills-catalog/`

## Protocol

### 1. Identify Needed Domain Skill
When a user prompt or subtask requires deep domain guidance (e.g., Next.js App Router, Flutter, Rust async, Neon Postgres, Tailwind v4, SEO, Auth/Clerk):
1. Consult the index: [SKILL_INDEX.md](file:///Users/sam/.gemini/config/skills-catalog/skill-picker/SKILL_INDEX.md)
2. Or locate the exact skill directory: `/Users/sam/.gemini/config/skills-catalog/<skill-name>/SKILL.md`

### 2. Read On-Demand
Use `view_file` to read ONLY the specific skill's `SKILL.md` for the duration of that task.
Example:
`view_file(AbsolutePath="/Users/sam/.gemini/config/skills-catalog/flutter-expert/SKILL.md")`

### 3. Session Activation (Optional)
If a user indicates an entire project or extended session will focus on a specific stack (e.g., full Flutter project):
Symlink that skill from the catalog into `/Users/sam/.gemini/config/skills/<skill-name>`:
```bash
ln -s /Users/sam/.gemini/config/skills-catalog/<skill-name> /Users/sam/.gemini/config/skills/<skill-name>
```
To deactivate after completion:
```bash
rm /Users/sam/.gemini/config/skills/<skill-name>
```

### 4. Direct Catalog Lookup Table
- **Next.js / React Web**: [nextjs-app-router-patterns](file:///Users/sam/.gemini/config/skills-catalog/nextjs-app-router-patterns/SKILL.md), [react-best-practices](file:///Users/sam/.gemini/config/skills-catalog/react-best-practices/SKILL.md), [react-state-management](file:///Users/sam/.gemini/config/skills-catalog/react-state-management/SKILL.md)
- **Styling**: [tailwind-design-system](file:///Users/sam/.gemini/config/skills-catalog/tailwind-design-system/SKILL.md), [ui-ux-pro-max](file:///Users/sam/.gemini/config/skills-catalog/ui-ux-pro-max/SKILL.md)
- **Mobile**: [flutter-expert](file:///Users/sam/.gemini/config/skills-catalog/flutter-expert/SKILL.md), [ios-developer](file:///Users/sam/.gemini/config/skills-catalog/ios-developer/SKILL.md), [react-native-architecture](file:///Users/sam/.gemini/config/skills-catalog/react-native-architecture/SKILL.md)
- **Backend / Python / Node**: [fastapi-pro](file:///Users/sam/.gemini/config/skills-catalog/fastapi-pro/SKILL.md), [nodejs-backend-patterns](file:///Users/sam/.gemini/config/skills-catalog/nodejs-backend-patterns/SKILL.md), [graphql-architect](file:///Users/sam/.gemini/config/skills-catalog/graphql-architect/SKILL.md)
- **Databases**: [postgres-best-practices](file:///Users/sam/.gemini/config/skills-catalog/postgres-best-practices/SKILL.md), [using-neon](file:///Users/sam/.gemini/config/skills-catalog/using-neon/SKILL.md), [prisma-expert](file:///Users/sam/.gemini/config/skills-catalog/prisma-expert/SKILL.md), [supabase-automation](file:///Users/sam/.gemini/config/skills-catalog/supabase-automation/SKILL.md)
- **Systems & Shell**: [rust-pro](file:///Users/sam/.gemini/config/skills-catalog/rust-pro/SKILL.md), [bash-pro](file:///Users/sam/.gemini/config/skills-catalog/bash-pro/SKILL.md), [git-advanced-workflows](file:///Users/sam/.gemini/config/skills-catalog/git-advanced-workflows/SKILL.md)
- **Auth**: [clerk-auth](file:///Users/sam/.gemini/config/skills-catalog/clerk-auth/SKILL.md), [auth-implementation-patterns](file:///Users/sam/.gemini/config/skills-catalog/auth-implementation-patterns/SKILL.md)
- **SEO & Growth**: [seo-fundamentals](file:///Users/sam/.gemini/config/skills-catalog/seo-fundamentals/SKILL.md), [ab-test-setup](file:///Users/sam/.gemini/config/skills-catalog/ab-test-setup/SKILL.md)
