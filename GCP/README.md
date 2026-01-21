# GCP Infrastructure Configuration

This directory contains Terraform configuration for deploying the Look-see infrastructure on Google Cloud Platform.

## Quick Start

1. **Copy the template**:
   ```bash
   cp terraform.tfvars.template terraform.tfvars
   ```

2. **Fill in your values** in `terraform.tfvars`

3. **Deploy**:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Documentation

- **[SETUP.md](SETUP.md)** - Complete setup guide
- **[terraform.tfvars.template](terraform.tfvars.template)** - Configuration template with all variables
- **[REMOTE_STATE_SETUP.md](REMOTE_STATE_SETUP.md)** - Remote state backend configuration
- **[DOMAIN_SETUP.md](DOMAIN_SETUP.md)** - Custom domain configuration
- **[SELENIUM_REVIEW.md](SELENIUM_REVIEW.md)** - Selenium configuration details

## Important Files

- `terraform.tfvars.template` - **Start here!** Copy this to `terraform.tfvars` and fill in your values
- `variables.tf` - Variable definitions
- `modules.tf` - Main infrastructure configuration
- `backend.tf` - Remote state backend configuration (optional)

## Security

- **Never commit `terraform.tfvars`** - It contains sensitive values
- **Never commit `*.tfstate` files** - Use remote state backend for production
- **Never commit credential JSON files** - Keep them secure and local

The `.gitignore` file is configured to exclude these files automatically.

## CI/CD Integration

This configuration is vendor-agnostic and works with any CI/CD system:

- **GitHub Actions**: See `.github/workflows/` (optional)
- **GitLab CI**: Use environment variables with `TF_VAR_` prefix
- **Jenkins**: Use environment variables or parameterized builds
- **Local Development**: Use `terraform.tfvars` file

All systems can use the same `terraform.tfvars.template` as a reference.
