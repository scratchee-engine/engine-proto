#!/bin/bash
# Bootstrap script to configure git hooks for scratchee-engine-proto
# Run once after cloning: ./scripts/setup-githooks.sh

set -e

cd "$(dirname "$0")/.."

echo "Configuring git to use .githooks/ directory..."
git config core.hooksPath .githooks

# Verify configuration applied (SEN-602: ensures commit-msg hook is active on fresh clones)
CONFIGURED=$(git config --get core.hooksPath || echo "")
if [ "$CONFIGURED" != ".githooks" ]; then
    echo "✗ Setup failed: core.hooksPath is '$CONFIGURED', expected '.githooks'"
    exit 1
fi

echo "✓ Git hooks configured"
echo "  pre-commit:  runs 'make precommit' before each commit"
echo "  commit-msg:  SEN-602 — warns on closing-keyword + Linear ticket-ID in commit body"
echo ""
echo "Commit-message convention (SEN-602):"
echo "  Iteration commits on umbrella tickets: 'Refs SEN-XXX' or 'Part of SEN-XXX'"
echo "  Only the final ship:                   'Fixes SEN-XXX' or 'Closes SEN-XXX' (auto-closes ticket)"
