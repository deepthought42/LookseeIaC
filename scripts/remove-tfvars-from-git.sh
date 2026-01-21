#!/bin/bash
# Script to remove terraform.tfvars from git tracking
# This ensures sensitive values are not committed to the repository

set -e

echo "Removing terraform.tfvars from git tracking..."

# Check if file exists
if [ -f "GCP/terraform.tfvars" ]; then
    echo "Found GCP/terraform.tfvars"
    
    # Remove from git index (but keep local file)
    git rm --cached GCP/terraform.tfvars 2>/dev/null || echo "File not tracked in git"
    
    echo "✓ Removed terraform.tfvars from git tracking"
    echo "  The file still exists locally but will not be committed"
else
    echo "terraform.tfvars not found - nothing to remove"
fi

# Verify .gitignore includes *.tfvars
if grep -q "\.tfvars" .gitignore 2>/dev/null; then
    echo "✓ .gitignore already includes *.tfvars"
else
    echo "⚠ Warning: .gitignore may not include *.tfvars"
fi

echo ""
echo "Next steps:"
echo "1. Commit this change: git commit -m 'Remove terraform.tfvars from tracking'"
echo "2. Configure GitHub Secrets as described in GCP/GITHUB_ACTIONS_SETUP.md"
echo "3. Use GitHub Actions workflows for deployments"


