data "google_iam_policy" "default" {
    binding {
        role = "roles/storage.admin"
        members = [
        "serviceAccount:${google_service_account.default.email}",
        ]
    }
    depends_on = [
        google_service_account.default
    ]
}

resource "google_storage_bucket" "default" {
    # name is fixed because startup.sh depends on it
    name            = "valheim-server-ashlands"
    location        = "US-CENTRAL1"
    storage_class   = "STANDARD"

    uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_policy" "policy" {
    bucket = google_storage_bucket.default.name
    policy_data = data.google_iam_policy.default.policy_data
    depends_on = [
    google_storage_bucket.default
  ]
}