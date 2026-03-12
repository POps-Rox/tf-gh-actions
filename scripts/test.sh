#!/usr/bin/env bash
set -euo pipefail

echo "=== Running Tests ==="
pytest tests/ "$@"
