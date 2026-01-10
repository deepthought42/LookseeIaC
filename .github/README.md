# GitHub Actions Workflows

This directory contains GitHub Actions workflows for Terraform infrastructure management.

## Workflows

### `terraform-plan.yml`
- **Triggers:** Pull requests to `main` or `develop` branches
- **Purpose:** Validates and plans Terraform changes
- **Output:** Comments the plan on the pull request

### `terraform-apply.yml`
- **Triggers:** 
  - Manual workflow dispatch (with environment selection)
  - Automatic on push to `main` branch
- **Purpose:** Applies Terraform changes to infrastructure
- **Environments:** dev, staging, prod

## Security

All sensitive values are stored as GitHub Secrets and never committed to the repository. The workflows automatically generate `terraform.tfvars` from secrets during execution.

See [GCP/GITHUB_ACTIONS_SETUP.md](../GCP/GITHUB_ACTIONS_SETUP.md) for detailed setup instructions.

## Quick Start

1. Configure all required secrets in GitHub (Settings → Secrets and variables → Actions)
2. Create a pull request to trigger `terraform-plan`
3. Use manual workflow dispatch to apply changes

