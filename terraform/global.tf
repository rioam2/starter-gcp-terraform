provider "google" {
  project = var.project_id
  region  = var.region
  version = "~> 3.65"
}

terraform {
  backend "gcs" {}
}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

