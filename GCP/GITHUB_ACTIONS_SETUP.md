# GitHub Actions Setup Guide (Optional)

> **Note**: This guide is **optional**. The infrastructure can be deployed using the template-based approach described in `SETUP.md` without any CI/CD system. This guide is for teams that want to use GitHub Actions specifically.

This guide explains how to configure GitHub Actions to securely manage Terraform deployments using GitHub Secrets instead of committing sensitive values to the repository.

## Overview

The GitHub Actions workflows automatically generate `terraform.tfvars` from GitHub Secrets during the CI/CD pipeline, ensuring sensitive values are never committed to the repository.

**Alternative**: For vendor-agnostic deployment, use the template-based approach:
1. Copy `terraform.tfvars.template` to `terraform.tfvars`
2. Fill in your values
3. Run `terraform apply`

See `SETUP.md` for the standard setup guide.

## Required GitHub Secrets

Configure the following secrets in your GitHub repository:

### Repository Settings
1. Go to your repository on GitHub
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret** for each secret below

### Required Secrets

#### GCP Configuration
- `GCP_CREDENTIALS_JSON` - Full JSON content of your GCP service account key file
- `TF_VAR_project_id` - Your GCP project ID (e.g., `webcrawler-450417`)
- `TF_VAR_region` - GCP region (e.g., `us-central1`)
- `TF_VAR_credentials_file` - Path to credentials file (e.g., `GCP-MyFirstProject-1c31159db52c.json`)

#### VPC Configuration
- `TF_VAR_vpc_name` - VPC network name (e.g., `custom-vpc`)
- `TF_VAR_subnet_cidr` - Subnet CIDR block (e.g., `10.0.0.0/24`)

#### Pusher Configuration
- `TF_VAR_pusher_key` - Pusher API key
- `TF_VAR_pusher_app_id` - Pusher application ID
- `TF_VAR_pusher_cluster` - Pusher cluster region (e.g., `us2`)
- `TF_VAR_pusher_secret` - Pusher secret

#### SMTP Configuration
- `TF_VAR_smtp_password` - SMTP password
- `TF_VAR_smtp_username` - SMTP username

#### Neo4j Configuration
- `TF_VAR_neo4j_password` - Neo4j database password (initial password for admin user)
- `TF_VAR_neo4j_username` - Neo4j username (usually `neo4j`)
- `TF_VAR_neo4j_db_name` - Neo4j database name (usually `neo4j`)
- **Note**: The Bolt URI is automatically generated from the deployed Neo4j instance's IP address

#### Auth0 Configuration
- `TF_VAR_auth0_domain` - Auth0 domain (e.g., `dev-look-see.us.auth0.com`)
- `TF_VAR_auth0_audience` - Auth0 audience (e.g., `https://api.look-see.com`)
- `TF_VAR_auth0_client_id` - Auth0 client ID
- `TF_VAR_auth0_client_secret` - Auth0 client secret
- `TF_VAR_auth0_management_api_client_id` - Auth0 Management API client ID
- `TF_VAR_auth0_management_api_client_secret` - Auth0 Management API client secret
- `TF_VAR_auth0_management_api_audience` - Auth0 Management API audience
- `TF_VAR_auth0_management_api_domain` - Auth0 Management API domain

#### Auth0 UI Configuration
- `TF_VAR_auth0_redirect_uri` - OAuth callback URL (e.g., `https://app.look-see.com/callback`)
- `TF_VAR_auth0_error_path` - Error path (e.g., `/error`) - Optional, defaults to `/error`
- `TF_VAR_auth0_app_uri` - Application URI (e.g., `https://app.look-see.com`)
- `TF_VAR_auth0_api_uri` - API URI (e.g., `https://api.look-see.com`)

#### Optional Configuration
- `TF_VAR_selenium_version` - Selenium standalone Chrome Docker image version/tag (default: `latest`)
  - Image will be: `docker.io/selenium/standalone-chrome:{version}`
  - Options: `latest`, `4.15.0`, `3.141.59`, etc.
- `TF_VAR_selenium_instance_count` - Number of Selenium instances (default: `1`)
- `TF_VAR_selenium_max_sessions` - Maximum concurrent sessions per Selenium instance (default: `1`)
  - Total concurrent sessions = `selenium_instance_count × selenium_max_sessions`
  - Example: 10 instances × 4 sessions = 40 total concurrent sessions
- `TF_VAR_domain_name` - Custom domain name for UI service (e.g., `looksee.com`) - Optional
- `TF_VAR_project_name` - Project name for labels (default: `looksee`)
- `TF_VAR_team_name` - Team name for labels (default: `devops`)

## Workflows

### Terraform Plan (Pull Requests)
- **Trigger:** Automatically runs on pull requests
- **Action:** Validates and plans Terraform changes
- **Location:** `.github/workflows/terraform-plan.yml`

### Terraform Apply (Manual/Production)
- **Trigger:** 
  - Manual workflow dispatch (with environment selection)
  - Automatic on push to `main` branch
- **Action:** Applies Terraform changes
- **Location:** `.github/workflows/terraform-apply.yml`

## Usage

### Running Terraform Plan (PR)
1. Create a pull request with Terraform changes
2. The workflow automatically runs and comments the plan on the PR

### Running Terraform Apply (Manual)
1. Go to **Actions** tab in GitHub
2. Select **Terraform Apply** workflow
3. Click **Run workflow**
4. Select the environment (dev, staging, prod)
5. Click **Run workflow**

### Running Terraform Apply (Automatic)
- Push changes to the `main` branch
- The workflow automatically applies changes

## Security Best Practices

1. **Never commit `terraform.tfvars`** - It's already in `.gitignore` (via `*.tfvars`)
2. **Rotate secrets regularly** - Update GitHub Secrets periodically
3. **Use environment-specific secrets** - Consider using GitHub Environments for different environments
4. **Limit workflow permissions** - Review and restrict workflow permissions in repository settings
5. **Audit secret access** - Regularly review who has access to repository secrets

## Removing terraform.tfvars from Git History

If `terraform.tfvars` was previously committed, remove it from git history:

```bash
# Remove from git tracking (if already committed)
git rm --cached GCP/terraform.tfvars

# Add to .gitignore (already done via *.tfvars)
# Commit the removal
git commit -m "Remove terraform.tfvars from tracking"

# If you need to remove from history (use with caution)
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch GCP/terraform.tfvars" \
  --prune-empty --tag-name-filter cat -- --all
```

## Troubleshooting

### Workflow fails with "secret not found
- Ensure all required secrets are configured in GitHub
- Check secret names match exactly (case-sensitive)

### Terraform apply fails
- Check GCP credentials are valid
- Verify all required APIs are enabled in GCP
- Review Terraform logs in the Actions tab

### Domain mapping fails
- Ensure `TF_VAR_domain_name` is set if using custom domain
- Verify DNS records are configured correctly
- Check domain ownership in Google Cloud Console

## Local Development

For local development, you can still use `terraform.tfvars`:

1. Copy the template: `cp GCP/terraform.tfvars.template GCP/terraform.tfvars`
2. Fill in your values (this file is gitignored)
3. Run `terraform apply` locally

**Important:** Never commit your local `terraform.tfvars` file!

