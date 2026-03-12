# Teamwork — Central Command Interface
# ======================================
# This Makefile is the single entry point for all project operations.
# AI agents and human developers use the same targets.
#
# Usage: make <target>
#   Run `make help` (or just `make`) to see available targets.

.DEFAULT_GOAL := help

.PHONY: help setup lint test build check plan review clean docker-build docker-run release

help: ## Show this help message
	@echo "Teamwork — available targets:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'
	@echo ""

setup: ## One-time dev environment setup
	@bash scripts/setup.sh

lint: ## Run linters (flake8, mypy, terraform fmt, tflint)
	@bash scripts/lint.sh

test: ## Run tests (pytest)
	@bash scripts/test.sh

build: ## Build the Docker image
	@bash scripts/build.sh

check: lint test build ## Run lint + test + build in sequence

plan: ## Invoke planning agent (usage: make plan GOAL="description")
	@bash scripts/plan.sh "$(GOAL)"

review: ## Invoke review agent (usage: make review REF="pr-number-or-branch")
	@bash scripts/review.sh "$(REF)"

clean: ## Remove build artifacts
	@echo "Cleaning build artifacts..."
	@rm -rf dist/
	@echo "Clean complete."

# --- Docker ---

docker-build: ## Build the actions Docker image
	@docker build -t tf-actions image/

docker-run: ## Run a command in the actions container (usage: make docker-run CMD="terraform version")
	@docker run --rm -v "$(PWD):/work" tf-actions $(CMD)

# --- Release ---

release: ## Create a new release (usage: make release VERSION=v1.35.0)
	@test -n "$(VERSION)" || (echo "Usage: make release VERSION=v1.35.0" && exit 1)
	@echo "=== Releasing $(VERSION) ==="
	@echo "Step 1: Running tests..."
	@bash scripts/test.sh
	@echo "Step 2: Verifying CHANGELOG..."
	@grep -q "$(VERSION)" CHANGELOG.md || (echo "ERROR: CHANGELOG.md missing $(VERSION) entry" && exit 1)
	@echo "Step 3: Creating git tag..."
	git tag -a $(VERSION) -m "Release $(VERSION)"
	git push origin $(VERSION)
	@echo "Step 4: Creating GitHub release..."
	gh release create $(VERSION) --title "$(VERSION)" --generate-notes
	@echo "=== $(VERSION) released ==="
