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
  secret_data_wo = var.pusher_app_id
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
  secret_data_wo = var.pusher_cluster
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

# Pusher Key Secret
resource "google_secret_manager_secret" "pusher_secret" {
  secret_id = "pusher-secret"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "pusher_secret_version" {
  secret         = google_secret_manager_secret.pusher_secret.id
  secret_data_wo = var.pusher_secret
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

resource "google_secret_manager_secret" "auth0_domain" {
  secret_id = "auth0-domain"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "auth0_domain_version" {
  secret         = google_secret_manager_secret.auth0_domain.id
  secret_data_wo = var.auth0_domain
}

resource "google_secret_manager_secret" "auth0_audience" {
  secret_id = "auth0-audience"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "auth0_audience_version" {
  secret         = google_secret_manager_secret.auth0_audience.id
  secret_data_wo = var.auth0_audience
}

resource "google_secret_manager_secret" "auth0_client_id" {
  secret_id = "auth0-client-id"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "auth0_client_id_version" {
  secret         = google_secret_manager_secret.auth0_client_id.id
  secret_data_wo = var.auth0_client_id
}

resource "google_secret_manager_secret" "auth0_client_secret" {
  secret_id = "auth0-client-secret"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "auth0_client_secret_version" {
  secret         = google_secret_manager_secret.auth0_client_secret.id
  secret_data_wo = var.auth0_client_secret
}

resource "google_secret_manager_secret" "auth0_management_api_client_id" {
  secret_id = "auth0-management-api-client-id"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "auth0_management_api_client_id_version" {
  secret         = google_secret_manager_secret.auth0_management_api_client_id.id
  secret_data_wo = var.auth0_management_api_client_id
}

resource "google_secret_manager_secret" "auth0_management_api_client_secret" {
  secret_id = "auth0-management-api-client-secret"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "auth0_management_api_client_secret_version" {
  secret         = google_secret_manager_secret.auth0_management_api_client_secret.id
  secret_data_wo = var.auth0_management_api_client_secret
}

resource "google_secret_manager_secret" "auth0_management_api_audience" {
  secret_id = "auth0-management-api-audience"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "auth0_management_api_audience_version" {
  secret         = google_secret_manager_secret.auth0_management_api_audience.id
  secret_data_wo = var.auth0_management_api_audience
}

resource "google_secret_manager_secret" "auth0_management_api_domain" {
  secret_id = "auth0-management-api-domain"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "auth0_management_api_domain_version" {
  secret         = google_secret_manager_secret.auth0_management_api_domain.id
  secret_data_wo = var.auth0_management_api_domain
}

# Selenium URLs Secret
resource "google_secret_manager_secret" "selenium_urls" {
  secret_id = "seleniumurls"
  project   = var.project_id

  labels = {
    environment = var.environment
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "selenium_urls_version" {
  secret         = google_secret_manager_secret.selenium_urls.id
  secret_data_wo = jsonencode(var.selenium_urls)
}