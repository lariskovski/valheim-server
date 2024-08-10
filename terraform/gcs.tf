resource "google_storage_bucket_access_control" "default" {
  bucket = google_storage_bucket.default.name
  role   = "WRITE"
  entity = google_service_account.default.email
}

resource "google_storage_bucket" "default" {
    name            = "valheim-server-ashlands"
    location        = "US-CENTRAL1"
    storage_class   = "STANDARD"

    uniform_bucket_level_access = true
}