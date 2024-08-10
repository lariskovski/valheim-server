resource "google_service_account" "default" {
  account_id   = "${var.application}-custom-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "default" {
  name         = var.application
  machine_type = var.machine_type
  zone         = var.zone

  # tags = ["foo", "bar"]

  # boot_disk {
  #   initialize_params {
  #     image = "debian-cloud/debian-11"
  #     image = "ubuntu-2004-lts/ubuntu-2004-focal-v20240808"
  #     labels = {
  #       my_label = "value"
  #     }
  #   }
  # }

  // Local SSD disk
  # scratch_disk {
  #   interface = "NVME"
  # }

  network_interface {
    network = "default"

    # access_config {
    #   // Ephemeral public IP
    # }
  }

  metadata = {
    app = var.application
  }

  # metadata_startup_script = "install fuse and valheim setup script"
  metadata_startup_script = file("${path.module}/startup.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    # cloud-platform allows full access to all Cloud APIs
    scopes = ["cloud-platform"]
  }
}
