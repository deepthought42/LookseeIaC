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
    #subnetwork = var.subnet_name       # optional, if using custom subnet

    # No external IP, so only accessible via VPC
    access_config {
      # Omit this block to prevent external IP assignment
    }
  }

  # Optionally, set tags for firewall rules
  tags = var.tags

  metadata = {
    # Set any required metadata here
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
    echo 'deb https://debian.neo4j.com stable 5' | sudo tee /etc/apt/sources.list.d/neo4j.list
    sudo apt-get update
    sudo apt-get install -y neo4j

    # Download the CQL file to /
    curl -o /home/neo4j/create-indexes-and-constraints.cql https://raw.githubusercontent.com/deepthought42/LookseeIaC/refs/heads/main/create-indexes-and-constraints.cql

    # Set initial password for neo4j admin user
    sudo systemctl stop neo4j
    sudo -u neo4j neo4j-admin set-initial-password '${var.neo4j_password}'
    sudo systemctl enable neo4j
    sudo systemctl start neo4j

    # Create a new user with the specified username and password
    sudo -u neo4j neo4j-admin create-user ${var.neo4j_username} '${var.neo4j_password}'

    # create database
    sudo -u neo4j neo4j-admin create-database ${var.neo4j_db_name}

    # run file to create indexes and constraints
    sudo -u neo4j neo4j-admin run /home/neo4j/create-indexes-and-constraints.cql
  EOT
}

# Firewall rule to allow access only from within the VPC
resource "google_compute_firewall" "neo4j-internal" {
  name    = "neo4j-allow-internal"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["7474", "7687"] # Neo4j HTTP and Bolt ports and ssh
  }

  source_ranges = var.source_ranges # Adjust to your VPC's CIDR
  target_tags   = var.target_tags
}

# Firewall rule to allow access only from within the VPC
resource "google_compute_firewall" "neo4j-iap-ssh" {
  name    = "neo4j-allow-iap-ssh"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["22"] # Neo4j HTTP and Bolt ports and ssh
  }

  source_ranges = ["35.235.240.0/20"] # Adjust to your VPC's CIDR
  target_tags   = var.target_tags
}
