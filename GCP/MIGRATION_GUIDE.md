# Terraform State Migration Guide

This guide walks you through migrating from local state to remote GCS backend.

## Prerequisites

✅ GCS bucket created: `terraform-state-webcrawler-450417`
✅ Backend configured in `backend.tf`
✅ GCP authentication configured

## Migration Steps

### 1. Verify Current State

```bash
cd GCP
terraform state list
```

This shows all resources currently tracked in your local state.

### 2. Initialize Backend and Migrate State

```bash
# This will detect the backend configuration and prompt to migrate
terraform init -migrate-state
```

When prompted:
- **"Do you want to copy existing state to the new backend?"** → Type `yes`
- Terraform will copy your local state to GCS

### 3. Verify Migration

```bash
# List resources (should show the same resources as before)
terraform state list

# Verify backend is being used
terraform state pull | head -20
```

You should see state is now being pulled from GCS.

### 4. Clean Up Local State (Optional)

After verifying everything works:

```bash
# Backup local state first (just in case)
cp terraform.tfstate terraform.tfstate.local-backup

# Remove local state (it's now in GCS)
rm terraform.tfstate terraform.tfstate.backup
```

### 5. Test Remote Backend

```bash
# Run a plan to ensure backend is working
terraform plan

# Should see: "Refreshing state..." which indicates remote state
```

## Verification Checklist

- [ ] `terraform state list` shows all your resources
- [ ] `terraform plan` runs without errors
- [ ] State is stored in GCS bucket: `gs://terraform-state-webcrawler-450417/terraform/state/default.tfstate`
- [ ] GitHub Actions can access the state (test with a plan workflow)

## Troubleshooting

### "Error: Failed to get existing workspaces"
- Ensure GCP authentication is working: `gcloud auth application-default login`
- Check bucket exists: `gsutil ls gs://terraform-state-webcrawler-450417`

### "Error: Backend configuration changed"
- Run: `terraform init -reconfigure`

### "Error acquiring state lock"
- Another Terraform operation is running
- Wait for it to complete
- If stuck, check GCS bucket for lock files

### State Migration Failed
- Your local state is still intact
- Check GCP permissions
- Verify bucket name in `backend.tf` matches the created bucket

## Next Steps

After successful migration:

1. **Test GitHub Actions**: Create a PR to trigger `terraform-plan` workflow
2. **Team Coordination**: Inform team members to run `terraform init` to use remote backend
3. **State Management**: State is now centralized - all team members and CI/CD use the same state

## Benefits You Now Have

✅ **Centralized State**: All environments use the same state file  
✅ **State Locking**: Prevents concurrent applies from corrupting state  
✅ **Version History**: GCS versioning keeps state history  
✅ **Security**: State stored securely in GCS with encryption  
✅ **CI/CD Ready**: GitHub Actions automatically uses remote backend  


