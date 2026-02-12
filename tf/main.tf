terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.17.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
