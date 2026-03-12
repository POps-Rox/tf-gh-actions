#!/usr/bin/env bash
set -euo pipefail

echo "=== Dev Environment Setup ==="

# Python test dependencies
if command -v pip &>/dev/null; then
  echo "Installing Python test dependencies..."
  pip install -r tests/requirements.txt
else
  echo "WARNING: pip not found — install Python 3 and pip first"
fi

# Pre-commit hooks
if command -v pre-commit &>/dev/null; then
  echo "Installing pre-commit hooks..."
  pre-commit install
else
  echo "Installing pre-commit..."
  pip install pre-commit
  pre-commit install
fi

echo "Setup complete."
