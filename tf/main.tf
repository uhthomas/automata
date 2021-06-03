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

resource "cloudflare_zone" "starjunk_net" {
  zone = var.cloudflare_zone
  plan = "business"
  type = "full"
}

resource "cloudflare_certificate_pack" "advanced_digicert_certificate_pack" {
  zone_id = cloudflare_zone.starjunk_net.id
  type    = "advanced"
  hosts = [
    var.cloudflare_zone,
    "*.${var.cloudflare_zone}",

    "mahalo.@",
    "*.mahalo.@",

    "pillowtalk.${var.cloudflare_zone}",
    "*.pillowtalk.${var.cloudflare_zone}",
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
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www_aaaa" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "www"
  value   = "100::"
  type    = "AAAA"
  ttl     = 1
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

# mahalo

resource "cloudflare_record" "mahalo_a" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "mahalo"
  value   = "51.159.112.126"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "grafana_mahalo_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "grafana.mahalo"
  value   = "mahalo.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "io_6f_dev_mahalo_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "io-6f-dev.mahalo"
  value   = "mahalo.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "io_6f_mahalo_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "io-6f.mahalo"
  value   = "mahalo.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "kipp_dev_mahalo_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "kipp-dev.mahalo"
  value   = "mahalo.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "kipp_mahalo_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "kipp.mahalo"
  value   = "mahalo.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "oauth2_proxy_mahalo_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "oauth2-proxy.mahalo"
  value   = "mahalo.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "rasmus_mahalo_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "rasmus.mahalo"
  value   = "mahalo.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "thanos_mahalo_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "thano.mahalo"
  value   = "mahalo.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

# pillowtalk

resource "cloudflare_record" "pillowtalk_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "pillowtalk"
  # TODO(thomas): Provision the tunnel with Terraform and use its attribute
  # in-place.
  value   = "29d849e6-cec2-4ddc-8672-1edd9eaaf2d2.cfargotunnel.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "ceph_pillowtalk_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "ceph.pillowtalk"
  value   = "pillowtalk.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "prometheus_pillowtalk_cname" {
  zone_id = cloudflare_zone.starjunk_net.id
  name    = "ceph.pillowtalk"
  value   = "pillowtalk.@"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
