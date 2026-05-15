# Git Hooks

## Pre-commit Hook

Validates that `package.json` version matches the current git tag (when committing on a tagged commit).

### Installation

```bash
git config core.hooksPath .githooks
```

Or manually symlink:

```bash
ln -sf ../../.githooks/pre-commit .git/hooks/pre-commit
```

### Requirements

- `jq` (for parsing package.json)

### Behavior

- On tagged commits: fails if package.json version doesn't match tag
- On non-tagged commits: passes (no check)
