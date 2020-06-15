provider "google" {
  region = var.region
}

terraform {
  backend "gcs" {}
}