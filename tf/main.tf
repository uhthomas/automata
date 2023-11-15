terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.19.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
