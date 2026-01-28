# Troubleshooting Guide

## Common Issues

### Error: "Invalid grant: account not found"

This error occurs when the service account referenced in your credentials file has been deleted or doesn't exist.

#### Solution: Create New Service Account Credentials

1. **Create a new service account in GCP Console:**
   ```bash
   # Option 1: Using gcloud CLI
   gcloud iam service-accounts create terraform-sa \
     --display-name="Terraform Service Account" \
     --project=webcrawler-450417
   
   # Grant necessary permissions
   gcloud projects add-iam-policy-binding webcrawler-450417 \
     --member="serviceAccount:terraform-sa@webcrawler-450417.iam.gserviceaccount.com" \
     --role="roles/owner"
   ```

2. **Create and download a key:**
   ```bash
   gcloud iam service-accounts keys create terraform-sa-key.json \
     --iam-account=terraform-sa@webcrawler-450417.iam.gserviceaccount.com \
     --project=webcrawler-450417
   ```

3. **Update `terraform.tfvars`:**
   ```hcl
   credentials_file = "terraform-sa-key.json"
   ```

4. **Verify credentials work:**
   ```bash
   gcloud auth activate-service-account --key-file=terraform-sa-key.json
   gcloud projects describe webcrawler-450417
   ```

#### Alternative: Use Application Default Credentials

If you prefer not to use a service account key file:

1. **Authenticate with your user account:**
   ```bash
   gcloud auth application-default login
   ```

2. **Remove or comment out the credentials line in `modules.tf`:**
   ```hcl
   provider "google" {
     project = var.project_id
     region  = var.region
     # credentials = file(var.credentials_file)  # Commented out to use ADC
   }
   ```

3. **Make `credentials_file` optional in `variables.tf`:**
   ```hcl
   variable "credentials_file" {
     description = "Path to GCP service account credentials JSON file (optional if using Application Default Credentials)"
     type        = string
     default     = null
   }
   ```

### Error: "Container import failed" - Docker Hub Rate Limiting

**Root Cause:** Docker Hub has rate limits (typically 100 pulls per 6 hours for anonymous users, 200 for authenticated free accounts). When Terraform creates multiple Cloud Run services in parallel, they all try to pull images simultaneously, hitting these limits.

**Solution:** Use the `-parallelism=1` flag to force Terraform to create resources sequentially, spacing out Docker Hub requests:
   ```bash
   terraform apply -parallelism=1
   ```
   This forces Terraform to create resources one at a time, preventing simultaneous Docker Hub requests.

**Alternative Solutions:**

1. **Authenticate with Docker Hub** (increases rate limit):
   - Create a Docker Hub account
   - Configure image pull secrets in Cloud Run (requires additional setup)

3. **Use GCP Artifact Registry** (recommended for production):
   - Pre-pull images to Artifact Registry
   - No rate limits
   - Faster pulls within GCP network

### Error: "Caller is not authorized to administer the domain"

**Root Cause:** The domain must be verified in your Google Cloud Platform project before it can be used for Cloud Run domain mapping. This is a one-time requirement to prove domain ownership.

**Solution:** Verify domain ownership in Google Cloud Console:

1. **Go to Google Cloud Console:**
   - Navigate to: https://console.cloud.google.com/run
   - Select your project
   - Click on **"Domain Mappings"** in the left sidebar

2. **Start Domain Verification:**
   - Click **"Add Mapping"** or **"Create Domain Mapping"**
   - Enter your domain (e.g., `look-see.com` or `app.look-see.com`)
   - Google Cloud will prompt you to verify domain ownership

3. **Add DNS Verification Record:**
   - Google Cloud will provide a TXT record to add to your DNS
   - The record will look like: `google-site-verification=XXXXXXXXXXXXX`
   - Add this TXT record to your domain's DNS provider:
     - **Name/Host:** `@` (for root domain) or your subdomain
     - **Type:** `TXT`
     - **Value:** The verification string provided by Google Cloud
     - **TTL:** Use default or 3600

4. **Complete Verification:**
   - Wait for DNS propagation (usually 5-30 minutes)
   - Click **"Verify"** in the Cloud Console
   - Once verified, the domain will be registered in your GCP project

5. **Retry Terraform Apply:**
   ```bash
   terraform apply
   ```

**Alternative: Using gcloud CLI:**
```bash
# Start domain verification
gcloud domains verify YOUR_DOMAIN

# After adding DNS record, verify it:
gcloud domains verify YOUR_DOMAIN --check-dns
```

**Note:** 
- Verify the root domain (e.g., `look-see.com`) if you plan to use subdomains. This covers all subdomains.
- Once verified, you can use any subdomain of that domain without re-verification.
- Domain verification is per GCP project.

**See Also:** `GCP/DOMAIN_SETUP.md` for complete domain setup instructions.

### Error: "Container import failed" or "Revision is not ready and cannot serve traffic" (Other Causes)

This error occurs when Cloud Run cannot pull the container image. Common causes:

1. **Image doesn't exist** - The Docker image at the specified location doesn't exist
2. **Private registry authentication** - Image is in a private registry and needs authentication
3. **Incorrect image reference** - The image path/format is incorrect
4. **Network/permission issues** - Cloud Run can't access the image registry  

#### Solution: Verify and Fix Image Configuration

1. **Check if the image exists:**
   ```bash
   # For Docker Hub images
   docker pull docker.io/deepthought42/journey-executor:latest
   
   # Or check on Docker Hub website
   # https://hub.docker.com/r/deepthought42/journey-executor
   ```

2. **Verify image reference format:**
   - Public Docker Hub: `docker.io/username/image:tag` or `username/image:tag`
   - GCP Artifact Registry: `REGION-docker.pkg.dev/PROJECT/REPO/IMAGE:TAG`
   - GCR: `gcr.io/PROJECT/IMAGE:TAG`

3. **If using a private registry, configure authentication:**
   ```hcl
   # In modules/cloud_run/main.tf, add image pull secrets
   template {
     spec {
       image_pull_secrets {
         name = "your-image-pull-secret"
       }
       # ... rest of config
     }
   }
   ```

4. **Use GCP Artifact Registry (recommended for production):**
   ```bash
   # Create Artifact Registry repository
   gcloud artifacts repositories create journey-executor \
     --repository-format=docker \
     --location=us-central1 \
     --project=webcrawler-450417
   
   # Build and push your image
   docker build -t us-central1-docker.pkg.dev/webcrawler-450417/journey-executor/journey-executor:latest .
   docker push us-central1-docker.pkg.dev/webcrawler-450417/journey-executor/journey-executor:latest
   ```

5. **Update terraform.tfvars with correct image:**
   ```hcl
   journey_executor_image = "us-central1-docker.pkg.dev/webcrawler-450417/journey-executor/journey-executor:latest"
   ```

6. **For development/testing, use a public test image:**
   ```hcl
   # Use a known working public image for testing
   journey_executor_image = "gcr.io/cloudrun/hello:latest"  # Test image
   ```

#### Quick Fix: Skip Failed Service Temporarily

If you need to deploy other services while fixing the image issue:

1. **Comment out the failing service in `modules.tf`:**
   ```hcl
   # module "journey_executor_cloud_run" {
   #   ...
   # }
   ```

2. **Deploy other services:**
   ```bash
   terraform apply
   ```

3. **Fix the image and uncomment the service**

### Required Service Account Permissions

The service account needs the following roles:
- `roles/owner` (for full Terraform management) OR
- `roles/editor` + specific roles for:
  - Cloud Run Admin
  - Service Account Admin
  - Secret Manager Admin
  - Compute Admin
  - Storage Admin
  - Pub/Sub Admin
  - VPC Access Admin
  - DNS Admin (if using custom domains)
  - Artifact Registry Reader (if using Artifact Registry images)