resource "google_secret_manager_secret" "secret" {
  project   = var.project_id
  secret_id = var.secret_name

  labels = var.labels

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "secret_version" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.secret_value
} 