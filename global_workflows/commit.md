---
description: Stage and commit all changes with an automatically generated conventional commit message.
---

1. Analyze the current changes in the workspace using `git status` and `git diff`.
2. Generate a concise, high-quality commit message following Conventional Commits standards.
// turbo
3. Stage all changes and commit immediately using the generated message.
4. Notify the user once the commit is successful.

Create a simple commit message based on diffs or memory in below format. DO NOT PUSH. Keep it concise. Always check the entire diff and understand the changes. There might be multiple rounds of changes/batched work performed by mulitple agents working in parallel. Try to make an educated guess about what was done. You can commit. 
Sometimes multiple changes may be wrongly committed into one message. Check the diff and amend the commit in that case

title (52ch)

 - point1 (70ch)
 - point 2 and so on