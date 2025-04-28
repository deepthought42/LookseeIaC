# Neo4j Password Secret
resource "google_secret_manager_secret" "neo4j_password" {
  secret_id = "neo4j-password"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "neo4j_password_version" {
  secret         = google_secret_manager_secret.neo4j_password.id
  secret_data_wo = var.neo4j_password
}

# Neo4j Username Secret
resource "google_secret_manager_secret" "neo4j_username" {
  secret_id = "neo4j-username"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "neo4j_username_version" {
  secret         = google_secret_manager_secret.neo4j_username.id
  secret_data_wo = var.neo4j_username
}

# Neo4j Bolt URI Secret
resource "google_secret_manager_secret" "neo4j_bolt_uri" {
  secret_id = "neo4j-bolt-uri"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "neo4j_bolt_uri_version" {
  secret         = google_secret_manager_secret.neo4j_bolt_uri.id
  secret_data_wo = var.neo4j_bolt_uri
}

# Neo4j Production Database Name Secret
resource "google_secret_manager_secret" "neo4j_db_name" {
  secret_id = "neo4j-db-name"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "neo4j_db_name_version" {
  secret         = google_secret_manager_secret.neo4j_db_name.id
  secret_data_wo = var.neo4j_db_name
}

# Pusher App ID Secret
resource "google_secret_manager_secret" "pusher_app_id" {
  secret_id = "pusher-app-id"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "pusher_app_id_version" {
  secret         = google_secret_manager_secret.pusher_app_id.id
  secret_data_wo = "1149968"
}

# Pusher Production Cluster Secret
resource "google_secret_manager_secret" "pusher_cluster" {
  secret_id = "pusher-cluster"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "pusher_cluster_version" {
  secret         = google_secret_manager_secret.pusher_cluster.id
  secret_data_wo = "us2"
}

# Pusher Key Secret
resource "google_secret_manager_secret" "pusher_key" {
  secret_id = "pusher-key"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "pusher_key_version" {
  secret         = google_secret_manager_secret.pusher_key.id
  secret_data_wo = var.pusher_key
}

# SMTP Password Secret
resource "google_secret_manager_secret" "smtp_password" {
  secret_id = "smtp-password"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "smtp_password_version" {
  secret         = google_secret_manager_secret.smtp_password.id
  secret_data_wo = var.smtp_password
}

# SMTP Username Secret
resource "google_secret_manager_secret" "smtp_username" {
  secret_id = "smtp-username"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "smtp_username_version" {
  secret         = google_secret_manager_secret.smtp_username.id
  secret_data_wo = var.smtp_username
}
