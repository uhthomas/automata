terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.11.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_zone" "starjunk_net" {
  account_id = var.cloudflare_account_id
  zone = var.cloudflare_zone
  plan = "business"
  type = "full"
}

resource "cloudflare_certificate_pack" "advanced_digicert_certificate_pack" {
  zone_id = cloudflare_zone.starjunk_net.id
  type    = "advanced"
  hosts = [
    cloudflare_zone.starjunk_net.zone,
    "*.${cloudflare_zone.starjunk_net.zone}",
  ]
  validation_method     = "txt"
  validity_days         = 30
  certificate_authority = "digicert"
  cloudflare_branding   = false

  lifecycle {
    create_before_destroy = true
  }
}
