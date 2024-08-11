# owner permission to the service account running on terraform cloud
# is not enough to do this permission giving
# add storage admin to it for a successfull run
module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 6.0"
  project_id  = var.project_id
  # name is fixed because startup.sh depends on it
  names = [var.application]
  location = "US-CENTRAL1"
  set_admin_roles = true
  admins = ["serviceAccount:${google_service_account.default.email}"]
  # bucket_admins = {
  #   second = "user:spam@example.com,user:eggs@example.com"
  # }
}

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

# resource "google_storage_bucket" "default" {
#     # name is fixed because startup.sh depends on it
#     name            = "valheim-server-ashlands"
#     location        = "US-CENTRAL1"
#     storage_class   = "STANDARD"

#     uniform_bucket_level_access = true
# }

# resource "google_storage_bucket_iam_policy" "policy" {
#     bucket = google_storage_bucket.default.name
#     policy_data = data.google_iam_policy.default.policy_data
#     depends_on = [
#     google_storage_bucket.default
#   ]
# }

variable "files" {
  type = map(string)
  default = {
    # sourcefile = destfile
    "objects/helloWorld.db" = "worlds_local/helloWorld.db",
    "objects/helloWorld.fwl" = "worlds_local/helloWorld.fwl",
  }
}
resource "google_storage_bucket_object" "objects" {
    for_each = var.files
    name     = each.value
    source   = "${path.module}/${each.key}"
    # bucket   = google_storage_bucket.default.name
    bucket   = var.application
    depends_on = [
      module.gcs_buckets
    ]
}