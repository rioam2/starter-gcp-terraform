provider "google" {
  project = var.project_id
  region  = var.region
  version = "~> 3.65"
}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}
