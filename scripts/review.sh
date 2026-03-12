#!/usr/bin/env bash
set -euo pipefail

REF="${1:-}"
if [ -z "$REF" ]; then
  echo "Usage: make review REF=\"pr-number-or-branch\""
  echo ""
  echo "This invokes the Teamwork review agent on a PR or branch."
  exit 1
fi

echo "Reviewing: $REF"
echo "Use the @reviewer agent in GitHub Copilot with this PR/branch."
