data "google_iam_policy" "default" {
  binding {
    role = "roles/storage.admin"
    members = [
      "serviceAccount:${google_service_account.default.email}",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "policy" {
  bucket = google_storage_bucket.default.name
  policy_data = data.google_iam_policy.default.policy_data
}

resource "google_storage_bucket" "default" {
    name            = "valheim-server-ashlands"
    location        = "US-CENTRAL1"
    storage_class   = "STANDARD"

    uniform_bucket_level_access = true
}