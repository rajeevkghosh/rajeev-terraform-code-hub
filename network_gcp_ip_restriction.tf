resource "google_dataproc_cluster" "simplecluster" {
  name   = "simplecluster"
  region = "us-central1"

  cluster_config {
    gce_cluster_config {
      zone = "us-central1-a"
      internel_ip_only = true

      # One of the below to hook into a custom network / subnetwork
      network    = "default"
      subnetwork = "default"
    }
  }
}