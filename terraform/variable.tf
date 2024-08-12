variable "project_id" {
  type        = string
  default     = "poc-laris"
}

variable "application" {
  type        = string
  default     = "valheim-server-ashlands"
}

variable "region" {
  type        = string
  default     = "us-central1"
}

variable "zone" {
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  type        = string
  default     = "e2-medium"
}

variable "create_network" {
  type        = bool
  default     = false
}

# existing world upload
variable "files" {
  type        = list(string)
  default     = ["JKART.db", "JKART.fwl"]
  description = "List of world files to be uploaded from the objects/ dir. The .db and .fwl or the .zip file (from backups)"
}
