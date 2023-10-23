moved {
  from = cloudflare_zone.terraform_managed_resource_acff21a4b43636283cd28bd5c5bd44a5
  to = cloudflare_zone.starjunk_net
}

resource "cloudflare_zone" "starjunk_net" {
  account_id = "cde22999fc6fe2ed5c9605561c508d29"
  paused     = false
  plan       = "business"
  type       = "full"
  zone       = "starjunk.net"
}

resource "cloudflare_record" "terraform_managed_resource_eedd8ec4c36e120ef1fc65c829c9bbc6" {
  name    = "amour"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "192.168.1.78"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_73b2e8833d39b494508d6ff7be831640" {
  name    = "ns1"
  proxied = false
  ttl     = 900
  type    = "A"
  value   = "162.159.8.218"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_c3feea6d5303a61f450f481d4b93c68a" {
  name    = "ns2"
  proxied = false
  ttl     = 900
  type    = "A"
  value   = "162.159.9.203"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_291857bf541534a054262fc4751a6bcd" {
  name    = "ns1"
  proxied = false
  ttl     = 900
  type    = "AAAA"
  value   = "2400:cb00:2049:1::162.159.8.218"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_8c0fbc31ad098d40f9eccb82bd237ff3" {
  name    = "ns2"
  proxied = false
  ttl     = 900
  type    = "AAAA"
  value   = "2400:cb00:2049:1::162.159.9.203"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

moved {
  from = cloudflare_record.terraform_managed_resource_96ab3ddbd1d6bda8e41ad733053b18aa
  to = cloudflare_record.aaaa
}

resource "cloudflare_record" "aaaa" {
  name    = "starjunk.net"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "100::"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

moved {
  from = cloudflare_record.terraform_managed_resource_1d02e7ffa92156a8528ad4263f5462c0
  to = cloudflare_record.www_aaaa
}

resource "cloudflare_record" "www_aaaa" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "100::"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_96494382737d342503bf7f2f6aa83332" {
  name    = "fm1._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm1.starjunk.net.dkim.fmhosted.com"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_1f45cbb0881abba9d2dff8072d550aae" {
  name    = "fm2._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm2.starjunk.net.dkim.fmhosted.com"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_9714dc1aa362bbdf836abd7354b82252" {
  name    = "fm3._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm3.starjunk.net.dkim.fmhosted.com"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_cfdd0862380adbfdc5a7442b0c243536" {
  name     = "starjunk.net"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_08f5abc0c8ab5c7f626df016d605c6ac" {
  name     = "starjunk.net"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_b80a3533e30542aa54abcac7747f8e41" {
  name    = "_dmarc"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=DMARC1;  p=none; rua=mailto:11e643eadb6648a8b81fc11bcfe022f9@dmarc-reports.cloudflare.net"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_37e047cce80565276348d26c57dd9861" {
  name    = "google._domainkey"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAntFvX1RJv3xAjH2gEvpBKh7MM95/SPJQSeX8QBpNByfkdlGwjgoES9WWY1HgRTOcnDYkR7+7pj6vTAIAkde75YWByT7wh16G+cjJ+zLOZwltegt18/69aQDqyT8nOw6Qb1itT4AhmBAG31z8F88T3pjbBqKAaNqyF4WBVjQfELHSoWnXvpuRC3VLj5Hlc0F8ghHQ9+m5tTnJkaWxdkTMRqO5fywUQhFP3CyNoCN6fBzkZNZgBIsqBELbKBAOHcLofV77DQLFgPomtUwzeRfVbEqDdTKVe0B6ybnHvYSLnaMcWMRxlPPYst/HI4WKOY/f3dzTI1ja8776VCO35rGRTQIDAQAB"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "terraform_managed_resource_73ef1766328832460724a6e3e780a257" {
  name    = "starjunk.net"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:spf.messagingengine.com ?all"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}
