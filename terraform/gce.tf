resource "google_service_account" "default" {
  account_id   = var.application
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "default" {
  name         = var.application
  machine_type = var.machine_type
  zone         = var.zone

  # tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      # gcloud compute images list | grep ubuntu
      # project/family
      image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
      # labels = {
      #   my_label = "value"
      # }
    }
  }

  // Local SSD disk
  # scratch_disk {
  #   interface = "NVME"
  # }

  network_interface {
    network = var.create_network ? module.vpc[0].network_name : data.google_compute_network.default[0].name

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    app = var.application
  }

  metadata_startup_script = file("${path.module}/startup.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    # cloud-platform allows full access to all Cloud APIs
    scopes = ["cloud-platform"]
  }
}
