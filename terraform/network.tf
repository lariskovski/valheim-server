# https://registry.terraform.io/modules/terraform-google-modules/network/google/9.1.0
module "vpc" {
    count = var.create_network ? 1 : 0
    source  = "terraform-google-modules/network/google"
    version = "~> 9.1"

    project_id   = var.project_id
    network_name = var.application
    routing_mode = "REGIONAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = var.region
        },
    ]

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
    ]
}

data "google_compute_network" "default" {
    count = var.create_network ? 0 : 1
    name = "default"
}