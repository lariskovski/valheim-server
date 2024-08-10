resource "google_storage_bucket" "default" {
    name     = var.application
    location = "US"
}