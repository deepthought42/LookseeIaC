# Custom Domain Setup Guide

This guide explains how to configure a custom domain for the UI service with automatic SSL certificate provisioning.

## Prerequisites

1. A domain name that you own (e.g., `example.com`)
2. Access to your domain's DNS provider
3. **The domain must be verified in your Google Cloud Platform project BEFORE creating the domain mapping** (see Step 1 below)

## Configuration Steps

### 1. Verify Domain Ownership in Google Cloud Console

**IMPORTANT:** You must verify domain ownership in your GCP project BEFORE running `terraform apply`. This is a one-time requirement.

#### Method 1: Through Google Cloud Console (Recommended)

1. **Go to Google Cloud Console:**
   - Navigate to: https://console.cloud.google.com/run
   - Select your project
   - Click on **"Domain Mappings"** in the left sidebar

2. **Start Domain Verification:**
   - Click **"Add Mapping"** or **"Create Domain Mapping"**
   - Enter your domain (e.g., `look-see.com` or `app.look-see.com`)
   - Google Cloud will prompt you to verify domain ownership

3. **Verify Domain Ownership:**
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

#### Method 2: Using gcloud CLI

```bash
# Start domain verification
gcloud domains verify look-see.com

# This will output a TXT record to add to your DNS
# After adding the DNS record, verify it:
gcloud domains verify look-see.com --check-dns
```

**Note:** 
- Verify the root domain (e.g., `look-see.com`) if you plan to use subdomains. This covers all subdomains.
- Once verified, you can use any subdomain without re-verification.
- Domain verification is per GCP project, so you only need to verify once per project.

### 2. Update terraform.tfvars

Add or update the `domain_name` variable in your `terraform.tfvars` file:

```hcl
domain_name = "app.example.com"  # Replace with your actual domain
```

**Note:** You can use a subdomain (e.g., `app.example.com`) or the root domain (e.g., `example.com`). Subdomains are recommended.

### 3. Update Auth0 Configuration

Make sure your Auth0 configuration in `terraform.tfvars` matches your custom domain:

```hcl
auth0_redirect_uri = "https://app.example.com/callback"
auth0_app_uri = "https://app.example.com"
auth0_api_uri = "https://api.example.com"  # Your API domain
```

### 4. Apply Terraform Configuration

```bash
terraform init
terraform plan
terraform apply
```

### 5. Configure DNS Records

After running `terraform apply`, Terraform will output the DNS records you need to configure. Check the output:

```bash
terraform output ui_domain_resource_records
```

You'll see output like:
```
[
  {
    name   = "app.example.com"
    type   = "CNAME"
    rrdata = "ghs.googlehosted.com."
  }
]
```

Add this CNAME record to your DNS provider:

- **Name/Host:** `app` (or the subdomain you chose)
- **Type:** `CNAME`
- **Value/Target:** `ghs.googlehosted.com.` (note the trailing dot)
- **TTL:** Use default or 3600

### 6. Wait for SSL Certificate Provisioning

Google Cloud Run automatically provisions an SSL certificate for your domain. This typically takes:

- **DNS propagation:** 5-30 minutes (depends on your DNS provider)
- **SSL certificate provisioning:** 5-15 minutes after DNS is configured

You can check the status:

```bash
terraform output ui_domain_ssl_certificate_status
```

### 7. Verify Domain Access

Once DNS has propagated and the SSL certificate is provisioned, you can access your UI service at:

```
https://app.example.com
```

## Troubleshooting

### Domain Mapping Status

Check the domain mapping status:

```bash
terraform output ui_domain_mapping_status
```

### Common Issues

1. **"Caller is not authorized to administer the domain" Error:**
   - **Cause:** Domain ownership not verified in your Google Cloud Platform project
   - **Solution:** Verify domain ownership in GCP Console first (see Step 1 above)
   - **Steps:**
     1. Go to Cloud Console → Cloud Run → Domain Mappings
     2. Click "Add Mapping" and enter your domain
     3. Add the provided TXT record to your DNS
     4. Complete verification in the Console
   - **Important:** Verify the root domain (e.g., `look-see.com`) to cover all subdomains

2. **DNS not configured:** Ensure the CNAME record is correctly added to your DNS provider

3. **DNS not propagated:** Wait longer or check with `dig app.example.com` or `nslookup app.example.com`

4. **SSL certificate pending:** Wait for Google to provision the certificate (can take up to 15 minutes)

5. **Domain verification failed:** Ensure you own the domain and have access to DNS records

### Manual Verification

You can also check the domain mapping in Google Cloud Console:

1. Go to Cloud Run → Domain Mappings
2. Find your domain mapping
3. Check the status and any error messages

## Optional: Using Cloud Run URL Only

If you don't want to use a custom domain, simply leave `domain_name` as `null` in your `terraform.tfvars`:

```hcl
domain_name = null
```

The UI service will still be accessible via the Cloud Run URL (output in `ui_service_url`).

## Additional Resources

- [Google Cloud Run Domain Mapping Documentation](https://cloud.google.com/run/docs/mapping-custom-domains)
- [DNS Configuration Guide](https://cloud.google.com/run/docs/mapping-custom-domains#dns)

