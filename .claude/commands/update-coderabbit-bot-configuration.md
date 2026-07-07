---
name: update-coderabbit-bot-configuration
description: Workflow command scaffold for update-coderabbit-bot-configuration in hermes-workspace.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /update-coderabbit-bot-configuration

Use this workflow when working on **update-coderabbit-bot-configuration** in `hermes-workspace`.

## Goal

Configures or updates the CodeRabbit review bot and its associated GitHub Actions workflow.

## Common Files

- `.github/coderabbit.yaml`
- `.coderabbit.yaml`
- `.github/workflows/coderabbit-trigger.yml`
- `.github/workflows/copilot-review.yml`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Edit or create .github/coderabbit.yaml or .coderabbit.yaml to configure CodeRabbit bot settings.
- Edit or create .github/workflows/coderabbit-trigger.yml to manage the workflow triggering CodeRabbit.
- Optionally edit .github/workflows/copilot-review.yml if Copilot review integration is involved.
- Commit changes with a message referencing CodeRabbit or Copilot review bots.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.