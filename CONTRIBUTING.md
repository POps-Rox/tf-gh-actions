# Contributing to tf-gh-actions

Thank you for your interest in contributing! This project is a suite of Docker-based GitHub Actions for Terraform.

## Development Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/POps-Rox/tf-gh-actions.git
   cd tf-gh-actions
   ```

2. **Install Python test dependencies:**
   ```bash
   pip install -r tests/requirements.txt
   ```

3. **Install pre-commit hooks:**
   ```bash
   pip install pre-commit
   pre-commit install
   ```

## Project Structure

```
terraform-*/          # Individual GitHub Actions (action.yaml + README)
image/
  Dockerfile          # Shared Docker image for all actions
  Dockerfile-base     # Base image with OS-level dependencies
  entrypoints/        # Bash entrypoint scripts (one per action)
  src/                # Python packages (core logic)
  tools/              # Python utility scripts
tests/                # pytest test suite
example_workflows/    # Example GitHub Actions workflows
docs/                 # Project documentation
```

## Running Tests

```bash
pytest tests/
```

## Linting

```bash
flake8 image/src/ tests/
mypy image/src/
terraform fmt -check -recursive
```

## Building the Docker Image

```bash
docker build -t tf-actions image/
```

## Pull Request Guidelines

- **One change per PR** — keep PRs focused and small (~300 lines max)
- **Write tests** for new behavior
- **Run tests locally** before opening a PR
- **Use conventional commits:** `type(scope): description`
  - `feat(plan):` for new features
  - `fix(apply):` for bug fixes
  - `docs:` for documentation changes
  - `chore:` for maintenance tasks
- **Link to an issue** if one exists

## Branch Naming

Use descriptive branch names: `feat/add-timeout-input`, `fix/plan-comment-format`, `docs/update-examples`.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
