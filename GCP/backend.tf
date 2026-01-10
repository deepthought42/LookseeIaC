terraform {
  backend "gcs" {
    bucket = "terraform-state-webcrawler-450417"
    prefix = "terraform/state"
  }
}

