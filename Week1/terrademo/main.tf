terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  # Credentials only needs to be set if you do not have the GOOGLE_APPLICATION_CREDENTIALS set
  project     = "thinking-land-410514"
  region      = "us-central1"
}



resource "google_storage_bucket" "demo-bucket" {
  name          = "thinking-land-410514-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 30 // days
    }
    action {
      type = "Delete"
    }
  }
  # Optional, but recommended settings:
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

}
