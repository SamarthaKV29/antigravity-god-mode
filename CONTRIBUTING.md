# Contributing to antigravity-god-mode

Thanks for helping grow **antigravity-god-mode**! Quality and low token overhead are the two core standards of this repository.

## Ways to Contribute

- **Add or refine a domain skill** in `skills-catalog/`
- **Add or tune a specialist subagent** in `plugins/antigravity-god-mode/` or `plugins/agency-agents/`
- **Improve workflows or setup automation** (`global_workflows/`, `setup.ps1`, `setup.sh`)
- **Report bugs, broken paths, or cross-platform issues**

---

## Contribution Guidelines

### 1. Adding a Domain Skill (`skills-catalog/`)
- Create `skills-catalog/<kebab-case-name>/SKILL.md` with YAML frontmatter:
  ```yaml
  ---
  name: my-skill-name
  description: One concise sentence describing when to load this skill.
  ---
  ```
- Register it in `skills-catalog/skill-picker/SKILL_INDEX.md` using a portable path (`~/.gemini/config/skills-catalog/<my-skill-name>/SKILL.md`)—never hardcode `/Users/<name>/` or `C:\Users\<name>\`.
- Keep `skills/` reserved for universal meta-skills only (`10` active core skills). If you update a core skill in `skills-catalog/`, copy the matching folder into `skills/`.

### 2. Adding or Updating a Subagent (`plugins/*/agents/`)
- Antigravity discovers subagents from `plugins/<plugin-name>/agents/*.md`.
- Required frontmatter schema:
  ```yaml
  ---
  name: my-specialist
  description: "Single crisp sentence (~70–110 chars) with trigger scope."
  tools:
    - read_file
    - grep_search
    - find_by_name
  subagent: true
  ---
  ```
- **Keep `description` short (~70–110 chars):** Every enabled subagent's `name` + `description` is injected per turn. Avoid fluff, unescaped quotes, or Claude-specific fields like `model: inherit` or comma-separated `skills:`.

### 3. Setup Scripts & Cross-Platform Safety
- Test Windows changes with `.\setup.ps1` (PowerShell 5.1 compatible; dual-IDE linking is opt-in via `-LinkIde`) and Unix changes with `bash -n setup.sh` (LF line endings).
- Keep setup **non-destructive by default**—never delete or overwrite existing user files without `-Update` / `--update` and `.bak` backups.
- Never commit personal configs, tokens, or runtime folders (see `.gitignore`).

---

## Pull Request Process

1. Fork the repository and create a feature branch (`git checkout -b feat/my-change`).
2. Keep PRs focused on a single skill, agent, fix, or workflow improvement.
3. Verify no hardcoded user paths (`/Users/...`, `C:\Users\...`) exist in your diff.
4. Open a PR using the repository template with a clear summary of what changed and how it was tested.
