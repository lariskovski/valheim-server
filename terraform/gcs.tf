# owner permission to the service account running on terraform cloud
# is not enough to do this permission giving
# add storage admin to it for a successfull run
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
    # explicitly noting not to destroy bucket if there are objects
    force_destroy   = false

    uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_policy" "policy" {
    bucket = google_storage_bucket.default.name
    policy_data = data.google_iam_policy.default.policy_data
    depends_on = [
    google_storage_bucket.default
  ]
}

resource "google_storage_bucket_object" "objects" {
    count   = length(var.files) > 0 ? length(var.files) : 0
    name    = "worlds_local/${var.files[count.index]"
    source  = "${path.module}/objects/${var.files[count.index]}"
    bucket  = google_storage_bucket.default.name
}
