---
description: UI/UX design workflow using superdesign CLI
---

# /superdesign - UI Design Workflow

$ARGUMENTS

---

## Task

This command runs the superdesign workflow for UI/UX design and iteration.

### Steps:

1. **Check CLI availability**
   - Run `superdesign --version`
   - If missing: `npm install -g @superdesign/cli@latest`

2. **Verify login**
   - Run `superdesign --help`
   - If auth error: `superdesign login`

3. **Initialize repo context (first time only)**
   - If `.superdesign/init/` is missing or empty:
     - Create the directory
     - Fetch init prompt:
       - `https://raw.githubusercontent.com/superdesigndev/superdesign-skill/main/skills/superdesign/INIT.md`
     - Follow its instructions to analyze the repo and write context files

4. **Load required context files (mandatory)**
   - Read all files in `.superdesign/init/`:
     - `components.md`, `layouts.md`, `routes.md`, `theme.md`, `pages.md`
   - When designing an existing page, use `pages.md` to collect dependencies

5. **Fetch latest superdesign guidelines**
   - `https://raw.githubusercontent.com/superdesigndev/superdesign-skill/main/skills/superdesign/SUPERDESIGN.md`
   - Apply instructions in that file

6. **Run design commands**
   - Create a project:
     - `superdesign create-project --title "<title>"`
   - Create a draft:
     - `superdesign create-design-draft --project-id <id> --title "<title>" -p "<prompt>" --context-file <path>`
   - Iterate a draft:
     - `superdesign iterate-design-draft --draft-id <id> -p "<prompt>" --mode branch --context-file <path>`
   - Extend to more pages:
     - `superdesign execute-flow-pages --draft-id <id> --pages '["<page>"]' --context-file <path>`

---

## Usage Examples

```
/superdesign design a marketing landing page
/superdesign iterate dashboard layout
/superdesign create design system for SaaS app
```

---

## Before Starting

If request is unclear, ask:
- Which pages or flows?
- What visual direction or references?
- Which stack or component library?
