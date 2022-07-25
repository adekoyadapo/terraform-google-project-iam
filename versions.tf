terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.25.0, < 5.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.25.0, < 5.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.2.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.3.2"
    }
  }
}