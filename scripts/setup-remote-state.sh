#!/bin/bash
# Script to set up GCS backend for Terraform state
# This ensures state is stored remotely and shared across environments

set -e

PROJECT_ID="${PROJECT_ID:-webcrawler-450417}"
BUCKET_NAME="${BUCKET_NAME:-terraform-state-${PROJECT_ID}}"
REGION="${REGION:-us-central1}"

echo "Setting up Terraform remote state backend..."
echo "Project: ${PROJECT_ID}"
echo "Bucket: ${BUCKET_NAME}"
echo "Region: ${REGION}"
echo ""

# Check if gcloud is installed
if ! command -v gsutil &> /dev/null; then
    echo "Error: gsutil not found. Please install Google Cloud SDK."
    exit 1
fi

# Check if bucket already exists
if gsutil ls -b "gs://${BUCKET_NAME}" &> /dev/null; then
    echo "✓ Bucket ${BUCKET_NAME} already exists"
else
    echo "Creating GCS bucket for Terraform state..."
    gsutil mb -p "${PROJECT_ID}" -l "${REGION}" "gs://${BUCKET_NAME}"
    echo "✓ Bucket created"
fi

# Enable versioning
echo "Enabling versioning on bucket..."
gsutil versioning set on "gs://${BUCKET_NAME}"
echo "✓ Versioning enabled"

# Create lifecycle configuration
echo "Setting up lifecycle rules..."
cat > /tmp/lifecycle.json <<EOF
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
EOF

gsutil lifecycle set /tmp/lifecycle.json "gs://${BUCKET_NAME}"
rm /tmp/lifecycle.json
echo "✓ Lifecycle rules configured"

# Encryption is enabled by default on GCS buckets
echo "✓ Encryption enabled by default (GCS default)"

# Update backend.tf
echo ""
echo "Updating backend.tf with bucket name..."
cd "$(dirname "$0")/../GCP" || exit 1

# Check if backend.tf exists
if [ -f "backend.tf" ]; then
    # Update bucket name if it's still the placeholder
    if grep -q "terraform-state-bucket-name" backend.tf; then
        sed -i "s/terraform-state-bucket-name/${BUCKET_NAME}/g" backend.tf
        echo "✓ Updated backend.tf with bucket name: ${BUCKET_NAME}"
    else
        echo "⚠ backend.tf already configured (may need manual update)"
    fi
else
    echo "⚠ backend.tf not found. Please create it manually."
fi

echo ""
echo "=========================================="
echo "Remote state setup complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Review GCP/backend.tf and update if needed"
echo "2. Run: cd GCP && terraform init -migrate-state"
echo "3. Verify: terraform state list"
echo ""
echo "Bucket details:"
echo "  Name: ${BUCKET_NAME}"
echo "  Location: gs://${BUCKET_NAME}/terraform/state"
echo ""

