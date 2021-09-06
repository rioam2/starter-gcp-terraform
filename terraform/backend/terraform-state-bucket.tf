resource "google_storage_bucket" "terraform-state-bucket" {
  name          = "${var.project_id}-terraform-state"
  project       = var.project_id
  location      = var.region
  storage_class = "STANDARD"
  force_destroy = true
  versioning {
    enabled = true
  }
}
