terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-state-webcrawler-450417"
    prefix = "terraform/state"
  }
}

