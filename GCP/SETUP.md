# Setup Guide

This guide walks you through setting up the infrastructure using Terraform. The configuration uses a simple template-based approach that works with any CI/CD system or local development.

## Quick Start

### 1. Copy the Template

```bash
cd GCP
cp terraform.tfvars.template terraform.tfvars
```

### 2. Fill in Your Configuration

Edit `terraform.tfvars` and replace all placeholder values with your actual configuration:

```hcl
# Required: GCP Project Configuration
project_id  = "your-gcp-project-id"
region      = "us-central1"
environment = "dev"

# Required: Service Account Credentials
credentials_file = "path/to/your/service-account-key.json"

# Required: Database Configuration
neo4j_password = "your-neo4j-password"  # Initial password for Neo4j admin user
neo4j_username = "neo4j"                 # Username (default: "neo4j")
neo4j_db_name  = "neo4j"                # Database name (default: "neo4j")
# Note: Bolt URI is automatically generated from the deployed instance's IP

# ... and so on for all other variables
```

See `terraform.tfvars.template` for all available configuration options.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review Changes

```bash
terraform plan
```

### 5. Apply Configuration

```bash
terraform apply
```

## Configuration Variables

All configuration variables are documented in `terraform.tfvars.template`. Key sections include:

- **GCP Project Configuration**: Project ID, region, environment
- **Service Account**: Path to GCP credentials JSON file
- **Neo4j Database**: Connection details for your Neo4j instance
- **Pusher**: Real-time messaging service configuration
- **SMTP**: Email service credentials
- **Auth0**: Authentication service configuration
- **VPC Network**: Network configuration
- **Selenium**: Browser automation configuration
- **Custom Domain**: Optional domain mapping for UI service

## Security Best Practices

### Never Commit Sensitive Values

The `.gitignore` file is configured to exclude:
- `terraform.tfvars` (your actual configuration)
- `*.tfstate` files (state files)
- Credential JSON files

**Always** use `terraform.tfvars.template` as your starting point, never commit your actual `terraform.tfvars` file.

### Using Environment Variables

Instead of using `terraform.tfvars`, you can also set variables via environment variables:

```bash
export TF_VAR_project_id="your-project-id"
export TF_VAR_region="us-central1"
export TF_VAR_neo4j_password="your-password"
# ... etc
terraform apply
```

### Using Remote State (Recommended)

For production deployments, configure remote state storage:

1. See `REMOTE_STATE_SETUP.md` for GCS backend configuration
2. Update `backend.tf` with your state bucket name
3. Run `terraform init -migrate-state` to migrate existing state

## Optional: Custom Domain Setup

If you want to use a custom domain for the UI service:

1. Set `domain_name` in `terraform.tfvars`:
   ```hcl
   domain_name = "app.example.com"
   ```

2. After `terraform apply`, configure DNS records as shown in the output:
   ```bash
   terraform output ui_domain_resource_records
   ```

3. See `DOMAIN_SETUP.md` for detailed instructions

## Troubleshooting

### "Error: Failed to get existing workspaces"
- Ensure GCP authentication is configured: `gcloud auth application-default login`
- Verify your service account JSON file path is correct

### "Error: Backend configuration changed"
- Run: `terraform init -reconfigure`

### "Error acquiring state lock"
- Another Terraform operation may be running
- Wait for it to complete, or check for stuck locks in your state backend

## Next Steps

- Review `terraform.tfvars.template` for all available options
- Check `REMOTE_STATE_SETUP.md` for production state management
- See `DOMAIN_SETUP.md` for custom domain configuration
- Review `SELENIUM_REVIEW.md` for Selenium configuration details
