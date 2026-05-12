#!/bin/bash
# Bootstrap script to configure git hooks for scratchee-engine-proto
# Run once after cloning: ./scripts/setup-githooks.sh

set -e

cd "$(dirname "$0")/.."

echo "Configuring git to use .githooks/ directory..."
git config core.hooksPath .githooks

echo "✓ Git hooks configured"
echo "Pre-commit hook will run 'make precommit' before each commit"
