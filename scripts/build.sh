#!/usr/bin/env bash
set -euo pipefail

echo "=== Building Docker Image ==="
docker build -t tf-actions image/
echo "Build complete: tf-actions"
