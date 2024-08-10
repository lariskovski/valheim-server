provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

terraform {
  required_version = ">= 1.1.7"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 5.38.0"
    }
  }
}