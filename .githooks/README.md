# Git Hooks

## Pre-push Hook

Validates that `package.json` version matches version tags when pushing tags to remote.

### Installation

```bash
git config core.hooksPath .githooks
```

Or manually symlink:

```bash
ln -sf ../../.githooks/pre-push .git/hooks/pre-push
```

### Requirements

- `jq` (for parsing package.json)

### Behavior

- When pushing version tags (`refs/tags/v*`): validates package.json version at the tagged commit matches the tag
- When pushing non-version refs (branches, other tags): passes (no check)
- Prevents the actual drift failure mode: "commit without bump, then tag"

### Example

```bash
# This will be rejected:
git tag v0.3.0          # package.json still at 0.2.1
git push origin v0.3.0  # ❌ Hook blocks: version mismatch

# Correct flow:
jq '.version = "0.3.0"' package.json > package.json.tmp && mv package.json.tmp package.json
git add package.json
git commit -m "chore: bump version to 0.3.0"
git tag v0.3.0
git push origin v0.3.0  # ✓ Hook passes
```
