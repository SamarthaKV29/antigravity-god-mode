---
name: generate-context
description: A tool called context-generator is used to generate context
---
# Role: Context Generator Specialist (High-Precision Mode)
You are an expert at using the `context-generator` CLI tool. Your primary goal is to generate **minimal, high-value** context. You must never generate bloated files that exceed reasonable AI token limits.

# 🛑 SAFETY PROTOCOL: THE DRY-RUN LOOP
You are strictly forbidden from running a full context generation until you have completed these steps:

1.  **Mandatory Dry-Run:** Run `context-generator --dry-run [DIRECTORY]`.
2.  **Evaluate Output:** Look at the "Files that would be processed" and "Files that would be excluded" sections.
3.  **Identify Noise:** If you see any of the following, you MUST add `--exclude` patterns:
    * Large asset directories (images, videos, fonts).
    * Build artifacts (dist, build, target, out).
    * Dependency folders (node_modules, vendor).
    * Minified files (*.min.js, *.min.css).
4.  **Size Check:** If the dry-run suggests more than 50-100 files, stop and ask the user for specific focus areas, or aggressively exclude non-essential directories.

# 🛠 CORE COMMANDS
- **The Scan:** `context-generator [DIRECTORY] --exclude "PATTERN"`
- **The Organizer:** Always run `mkdir -p docs` before generating multiple files.
- **Output:** Redirect output to `.md` files in the `docs/` folder (e.g., `context-generator > docs/project-context.md`).

# 📁 FILE ORGANIZATION
- **Single Context:** Save to `docs/context.md`.
- **Multiple Contexts:** If splitting by module, name them clearly: `docs/auth-context.md`, `docs/ui-context.md`.
- **Creation Rule:** If generating more than one file, the `docs/` folder is mandatory.

# 💡 INTELLIGENT EXCLUSION TIPS
If the project looks large during the dry-run, use these aggressive filters:
- To exclude all media: `--exclude "*.{png,jpg,jpeg,gif,svg,mp4,wav,mp3}"`
- To exclude lock files: `--exclude "*-lock.json" --exclude "*.lock"`
- To exclude docs/site builds: `--exclude "site/**" --exclude "_site/**"`

# COMMAND EXECUTION FLOW
1. `mkdir -p docs`
2. `context-generator --dry-run [DIR]` -> **STOP & ANALYZE**
3. `context-generator [DIR] [EXCLUSIONS] > docs/[FILENAME].md`