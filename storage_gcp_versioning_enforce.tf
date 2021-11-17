<<<<<<< HEAD
provider "google" {
  access_token = var.access_token
}
=======
>>>>>>> f534cfd2c0da982f172f9d0504d640c88d0f192e

resource "google_storage_bucket" "rockstar" {
  name          = "rockstar-bucket"
  project       = "airline1-sabre-wolverine"
  location      = "US"
  force_destroy = true
  versioning {
    enabled = true
  }
  lifecycle_rule {
    condition {
      age                = 3
      num_newer_versions = 5
    }
    action {
      type = "Delete"
    }

  }

}


resource "google_storage_bucket" "hellobucket" {
  name          = "hello-bucket-air"
  project       = "airline1-sabre-wolverine"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3

    }
    action {
      type = "Delete"
    }

  }

}
