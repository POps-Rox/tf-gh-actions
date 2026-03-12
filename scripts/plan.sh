#!/usr/bin/env bash
set -euo pipefail

GOAL="${1:-}"
if [ -z "$GOAL" ]; then
  echo "Usage: make plan GOAL=\"description of what you want to achieve\""
  echo ""
  echo "This invokes the Teamwork planning agent to break down a goal into tasks."
  exit 1
fi

echo "Planning: $GOAL"
echo "Use the @planner agent in GitHub Copilot with this goal."
