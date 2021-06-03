terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.21.0"
    }
  }
}

provider "cloudflare" {
  email     = "thomas@6f.io"
  api_token = var.cloudflare_api_token
}

resource "cloudflare_certificate_pack" "advanced_digicert_certificate_pack" {
  zone_id = var.zone_id
  type    = "advanced"
  hosts = [
    var.zone,
    "*.${var.zone}",

    "mahalo.${var.zone}",
    "*.mahalo.${var.zone}",

    "pillowtalk.${var.zone}",
    "*.pillowtalk.${var.zone}",
  ]
  validation_method     = "txt"
  validity_days         = 30
  certificate_authority = "digicert"
  cloudflare_branding   = false

  lifecycle {
    create_before_destroy = true
  }
}
