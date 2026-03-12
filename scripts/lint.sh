#!/usr/bin/env bash
set -euo pipefail

echo "=== Running Linters ==="

ERRORS=0

# Python linting
if command -v flake8 &>/dev/null; then
  echo "--- flake8 ---"
  flake8 image/src/ tests/ || ERRORS=1
else
  echo "WARNING: flake8 not found (pip install flake8)"
  ERRORS=1
fi

if command -v mypy &>/dev/null; then
  echo "--- mypy ---"
  mypy image/src/ || ERRORS=1
else
  echo "WARNING: mypy not found (pip install mypy)"
  ERRORS=1
fi

# Terraform formatting
if command -v terraform &>/dev/null; then
  echo "--- terraform fmt ---"
  terraform fmt -check -recursive -diff || ERRORS=1
else
  echo "SKIP: terraform not found"
fi

# TFLint
if command -v tflint &>/dev/null; then
  echo "--- tflint ---"
  tflint --recursive --format compact || ERRORS=1
else
  echo "SKIP: tflint not found"
fi

if [ "$ERRORS" -ne 0 ]; then
  echo "Linting failed."
  exit 1
fi

echo "All linters passed."
