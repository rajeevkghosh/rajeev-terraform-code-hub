resource "google_pubsub_topic" "example" {
  name = "example-topic"

  message_storage_policy {
    allowed_persistence_regions = [
      "us-central1", "us-east-1", "us-west-1"
    ]
  }
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "example_dataset"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "US"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }

}

resource "google_dataproc_cluster" "mycluster" {
  name                          = "mycluster"
  region                        = "us-central1"
  graceful_decommission_timeout = "120s"

  labels = {
    env = "dev"
    foo = "bar"
  }

  cluster_config {
    gce_cluster_config {
      zone             = "us-central1-a"
      internal_ip_only = true

      # One of the below to hook into a custom network / subnetwork
      subnetwork = "default"
    }
    endpoint_config {
      enable_http_port_access = "true"
    }
  }
}


resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "secret"

  labels = {
    label = "my-label"
  }

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
      replicas {
        location = "us-east1"
      }
    }
  }
}

resource "google_dialogflow_cx_agent" "full_agent" {
  display_name               = "dialogflowcx-agent"
  location                   = "us-central1"
  default_language_code      = "en"
  supported_language_codes   = ["fr", "de", "es"]
  time_zone                  = "America/New_York"
  description                = "Example description."
  avatar_uri                 = "https://cloud.google.com/_static/images/cloud/icons/favicons/onecloud/super_cloud.png"
  enable_stackdriver_logging = true
  enable_spell_correction    = true
  speech_to_text_settings {
    enable_speech_adaptation = true
  }
}

resource "google_compute_interconnect_attachment" "on_prem" {
  name                     = "on-prem-attachment"
  region                   = "us-central1"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  type                     = "PARTNER"
  router                   = google_compute_router.foobar.id
  mtu                      = 1500
}

resource "google_compute_router" "foobar" {
  name    = "router"
  network = google_compute_network.foobar.name
  bgp {
    asn = 16550
  }
}

resource "google_compute_network" "foobar" {
  name                    = "network"
  auto_create_subnetworks = false
}