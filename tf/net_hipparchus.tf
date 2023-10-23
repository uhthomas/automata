resource "cloudflare_record" "terraform_managed_resource_d51aea2d5e1c71a0643f272d4f7c0b04" {
  name    = "_dmarc"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "\"v=DMARC1;  p=none; rua=mailto:ab09c867dfbc4acdac68a0759f81bf62@dmarc-reports.cloudflare.net\""
  zone_id = "8e603296b42075dc4f1754b63f2ce5de"
}

resource "cloudflare_record" "terraform_managed_resource_2a6e2c824887f0ec050508bfa45670c9" {
  name    = "hipparchus.net"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 -all"
  zone_id = "8e603296b42075dc4f1754b63f2ce5de"
}

resource "cloudflare_record" "terraform_managed_resource_2dbc3f10af7d65dc6c5088bd419901f7" {
  name    = "hipparchus.net"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "100::"
  zone_id = "8e603296b42075dc4f1754b63f2ce5de"
}
