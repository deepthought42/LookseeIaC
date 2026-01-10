# Remote State Setup Guide

## Why Remote State is Critical

Having `terraform.tfstate` in `.gitignore` without a remote backend causes serious problems:

1. **State Isolation**: Each environment (local, GitHub Actions) has its own state file
2. **Resource Conflicts**: Terraform loses track of existing resources and tries to recreate them
3. **No State Locking**: Multiple applies can run simultaneously, corrupting state
4. **Lost Infrastructure**: Changes made in one environment aren't visible to others

## Solution: GCS Backend

Use Google Cloud Storage (GCS) as a remote backend to store state centrally.

## Setup Steps

### 1. Create GCS Bucket for State

```bash
# Set your project
export PROJECT_ID="webcrawler-450417"
export BUCKET_NAME="terraform-state-${PROJECT_ID}"

# Create bucket
gsutil mb -p ${PROJECT_ID} -l us-central1 gs://${BUCKET_NAME}

# Enable versioning (recommended)
gsutil versioning set on gs://${BUCKET_NAME}

# Enable object versioning for state recovery
gsutil lifecycle set lifecycle.json gs://${BUCKET_NAME}
```

Create `lifecycle.json`:
```json
{
  "lifecycle": {
    "rule": [
      {
        "action": {"type": "Delete"},
        "condition": {"numNewerVersions": 10}
      }
    ]
  }
}
```

### 2. Configure Backend

Update `GCP/backend.tf` with your bucket name:

```hcl
terraform {
  backend "gcs" {
    bucket = "terraform-state-webcrawler-450417"  # Your bucket name
    prefix = "terraform/state"
  }
}
```

### 3. Migrate Existing State

If you have existing local state:

```bash
cd GCP

# Initialize backend (will prompt to migrate)
terraform init -migrate-state

# Verify migration
terraform state list
```

### 4. Update GitHub Actions

The workflows already authenticate to GCP, so they'll automatically use the backend.

### 5. Verify Setup

```bash
# Check state location
terraform state list

# Verify backend configuration
cat .terraform/terraform.tfstate
```

## Backend Configuration Options

### Environment-Specific State

For multiple environments, use different prefixes:

```hcl
terraform {
  backend "gcs" {
    bucket = "terraform-state-webcrawler-450417"
    prefix = "terraform/state/${var.environment}"  # dev, staging, prod
  }
}
```

### State Encryption

Enable encryption at rest:

```bash
# Enable default encryption
gsutil encryption set on gs://${BUCKET_NAME}
```

### Access Control

Restrict access to the state bucket:

```bash
# Remove public access
gsutil iam ch -d allUsers:objectViewer gs://${BUCKET_NAME}

# Grant access only to service account
gsutil iam ch serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com:objectAdmin gs://${BUCKET_NAME}
```

## Troubleshooting

### "Backend configuration changed"
- Run `terraform init -reconfigure` to reinitialize

### "Error acquiring state lock"
- Another Terraform operation is running
- Wait for it to complete, or manually remove the lock if stuck

### "State file not found"
- Verify bucket name and prefix are correct
- Check GCP authentication
- Verify bucket exists and is accessible

## Best Practices

1. **Enable Versioning**: Allows recovery of previous state versions
2. **Use Prefixes**: Separate state by environment/project
3. **Restrict Access**: Only grant necessary permissions
4. **Enable Encryption**: Protect sensitive state data
5. **Regular Backups**: Consider additional backup strategy for critical infrastructure


