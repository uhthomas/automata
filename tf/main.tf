terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.7.1"
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

    "milkshake.${cloudflare_zone.starjunk_net.zone}",
    "*.milkshake.${cloudflare_zone.starjunk_net.zone}",
  ]
  validation_method     = "txt"
  validity_days         = 30
  certificate_authority = "digicert"
  cloudflare_branding   = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "aaaa" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "@"
  value   = "100::"
  type    = "AAAA"
  proxied = true
}

resource "cloudflare_record" "www_aaaa" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "www"
  value   = "100::"
  type    = "AAAA"
  proxied = true
}

# Google mail
resource "cloudflare_record" "mx" {
  zone_id  = cloudflare_zone.starjunk_net.id
  name     = "@"
  value    = "aspmx.l.google.com"
  type     = "MX"
  ttl      = 1
  priority = 1
}

resource "cloudflare_record" "alt_mx" {
  count = 4

  zone_id  = cloudflare_zone.starjunk_net.id
  name     = "@"
  value    = "alt${count.index + 1}.aspmx.l.google.com"
  type     = "MX"
  ttl      = 1
  priority = (floor(count.index / 2) + 1) * 5
}

# milkshake

resource "cloudflare_record" "milkshake_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "milkshake"
  # TODO(thomas): Provision the tunnel with Terraform and use its attribute
  # in-place.
  value   = "077009ac-357f-4adb-837c-f0af617908cd.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "twitch_milkshake_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "twitch.milkshake"
  value   = "milkshake.${cloudflare_zone.starjunk_net.zone}"
  type    = "CNAME"
  proxied = true
}

