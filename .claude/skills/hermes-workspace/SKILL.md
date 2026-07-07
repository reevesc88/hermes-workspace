```markdown
# hermes-workspace Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill provides guidance on contributing to the `hermes-workspace` TypeScript codebase. It covers the project's coding conventions, commit message standards, testing patterns, and repository-specific workflows—particularly around bot integrations and automation. By following these patterns, contributors ensure consistency, maintainability, and smooth collaboration.

## Coding Conventions

### File Naming
- Use **kebab-case** for all file names.
  - Example:  
    ```
    user-profile.ts
    data-fetcher.test.ts
    ```

### Import Style
- Use **relative imports** for internal modules.
  - Example:
    ```typescript
    import { fetchData } from './data-fetcher';
    import { UserProfile } from '../models/user-profile';
    ```

### Export Style
- Use **named exports** instead of default exports.
  - Example:
    ```typescript
    // Good
    export function fetchData() { ... }
    export const API_URL = '...';

    // Bad
    export default function fetchData() { ... }
    ```

### Commit Messages
- Follow **conventional commit** format.
- Use prefixes like `fix:` or `feat:`.
- Keep messages concise (average ~63 characters).
  - Example:
    ```
    feat: add user profile fetcher
    fix: correct typo in data-fetcher
    ```

## Workflows

### update-coderabbit-bot-configuration
**Trigger:** When you need to add, update, or fix the CodeRabbit review bot integration.  
**Command:** `/update-coderabbit-bot`

1. Edit or create `.github/coderabbit.yaml` or `.coderabbit.yaml` to configure CodeRabbit bot settings.
2. Edit or create `.github/workflows/coderabbit-trigger.yml` to manage the workflow that triggers CodeRabbit.
3. (Optional) Edit `.github/workflows/copilot-review.yml` if Copilot review integration is involved.
4. Commit your changes with a message referencing CodeRabbit or Copilot review bots.
   - Example:
     ```
     feat: update CodeRabbit bot configuration
     ```
5. Push your changes and open a pull request if needed.

**Files Involved:**
- `.github/coderabbit.yaml`
- `.coderabbit.yaml`
- `.github/workflows/coderabbit-trigger.yml`
- `.github/workflows/copilot-review.yml`

## Testing Patterns

- Test files follow the pattern: `*.test.*`
  - Example: `data-fetcher.test.ts`
- The specific testing framework is not detected; check existing test files for conventions.
- Place tests alongside the modules they test or in a dedicated `tests` directory if present.

## Commands

| Command                 | Purpose                                                        |
|-------------------------|----------------------------------------------------------------|
| /update-coderabbit-bot  | Configure or update the CodeRabbit review bot and workflows    |
```