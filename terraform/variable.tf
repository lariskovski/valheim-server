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
