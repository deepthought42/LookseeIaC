resource "google_compute_instance" "neo4j" {
  name         = "neo4j-community"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    network    = var.vpc_network_name  # e.g., "default" or your custom VPC
    subnetwork = var.subnet_name       # optional, if using custom subnet

    # Add external IP for internet access
    access_config {
      # Omit this block to prevent external IP assignment
    }
  }

  # Add http-server tag for firewall rule
  tags = concat(var.tags, ["iap-ssh", "http-server"])

  metadata = {
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = file("${path.module}/install-neo4j.sh")
}

# Firewall rule for internal VPC access
resource "google_compute_firewall" "neo4j-internal" {
  name    = "neo4j-allow-internal"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["7687"] # Neo4j Bolt ports
  }

  source_ranges = var.source_ranges # Adjust to your VPC's CIDR
  target_tags   = var.tags
}

# Firewall rule for internet access to Neo4j HTTP/HTTPS
resource "google_compute_firewall" "neo4j-allow-internet" {
  name    = "neo4j-allow-internet"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["7474"] # Neo4j HTTP/HTTPS port
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# 6. IAM binding for IAP Tunnel SSH
resource "google_iap_tunnel_instance_iam_member" "ssh" {
  project  = var.project_id
  zone     = var.zone
  instance = google_compute_instance.neo4j.name
  role     = "roles/iap.tunnelResourceAccessor"
  member   = "serviceAccount:${google_service_account.neo4j_instance_sa.email}"
}