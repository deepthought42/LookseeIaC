# Custom Domain Setup Guide

This guide explains how to configure a custom domain for the UI service with automatic SSL certificate provisioning.

## Prerequisites

1. A domain name that you own (e.g., `example.com`)
2. Access to your domain's DNS provider
3. The domain must be verified in Google Cloud (automatic during domain mapping creation)

## Configuration Steps

### 1. Update terraform.tfvars

Add or update the `domain_name` variable in your `terraform.tfvars` file:

```hcl
domain_name = "app.example.com"  # Replace with your actual domain
```

**Note:** You can use a subdomain (e.g., `app.example.com`) or the root domain (e.g., `example.com`). Subdomains are recommended.

### 2. Update Auth0 Configuration

Make sure your Auth0 configuration in `terraform.tfvars` matches your custom domain:

```hcl
auth0_redirect_uri = "https://app.example.com/callback"
auth0_app_uri = "https://app.example.com"
auth0_api_uri = "https://api.example.com"  # Your API domain
```

### 3. Apply Terraform Configuration

```bash
terraform init
terraform plan
terraform apply
```

### 4. Configure DNS Records

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

### 5. Wait for SSL Certificate Provisioning

Google Cloud Run automatically provisions an SSL certificate for your domain. This typically takes:

- **DNS propagation:** 5-30 minutes (depends on your DNS provider)
- **SSL certificate provisioning:** 5-15 minutes after DNS is configured

You can check the status:

```bash
terraform output ui_domain_ssl_certificate_status
```

### 6. Verify Domain Access

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

1. **DNS not configured:** Ensure the CNAME record is correctly added to your DNS provider
2. **DNS not propagated:** Wait longer or check with `dig app.example.com` or `nslookup app.example.com`
3. **SSL certificate pending:** Wait for Google to provision the certificate (can take up to 15 minutes)
4. **Domain verification failed:** Ensure you own the domain and have access to DNS records

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

