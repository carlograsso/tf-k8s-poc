terraform {
  required_version = "= 1.9.2"

  backend "s3" {
    bucket = "carlo-test-1122"
    key    = "poc"
    profile = "poc"
    region = "eu-south-1"
  }
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}