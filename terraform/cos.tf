# data "google_compute_image" "cos" {
#   family  = "cos-stable"
#   project = "cos-cloud"
# }

# resource "google_compute_instance" "container_optimized_os_vm" {
#   name                      = "container-optimized-os-vm"
#   machine_type              = "f1-micro"
#   allow_stopping_for_update = true

#   network_interface {
#     network = "default"
#   }

#   boot_disk {
#     initialize_params {
#       image = data.google_compute_image.cos.self_link
#     }
#   }

#  metadata = {
#     google-logging-enabled = "true"
#     gce-container-declaration =<<EOT
# spec:
#   containers:
#     - image: europe-west2-docker.pkg.dev/my-project-id/my-image-repository-name/my-image-name:latest
#       name: containervm
#       securityContext:
#         privileged: false
#       stdin: false
#       tty: false
#       volumeMounts: []
#       restartPolicy: Always
#       volumes: []
# EOT
#   }
# }
  