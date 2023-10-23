moved {
  from = cloudflare_zone.terraform_managed_resource_acff21a4b43636283cd28bd5c5bd44a5
  to   = cloudflare_zone.starjunk_net
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
  to   = cloudflare_record.aaaa
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
  to   = cloudflare_record.www_aaaa
}

resource "cloudflare_record" "www_aaaa" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "100::"
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

# Fastmail
#
# https://www.fastmail.help/hc/en-us/articles/360060591153-Manual-DNS-configuration

moved {
  from = cloudflare_record.terraform_managed_resource_08f5abc0c8ab5c7f626df016d605c6ac
  to   = cloudflare_record.net_starjunk_fastmail_mx_1
}

resource "cloudflare_record" "net_starjunk_fastmail_mx_1" {
  name     = "starjunk.net"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
}

moved {
  from = cloudflare_record.terraform_managed_resource_cfdd0862380adbfdc5a7442b0c243536
  to   = cloudflare_record.net_starjunk_fastmail_mx_2
}

resource "cloudflare_record" "net_starjunk_fastmail_mx_2" {
  name     = "starjunk.net"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
}

## Subdomain Mail

resource "cloudflare_record" "net_starjunk_fastmail_mail_mx_1" {
  name     = "*"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "net_starjunk_fastmail_mail_mx_2" {
  name     = "*"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
}

## Webmail Login Portal

resource "cloudflare_record" "net_starjunk_fastmail_webmail_login_portal" {
  name    = "mail"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "mail.fastmail.com"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

### Allow mail at subdomains

resource "cloudflare_record" "net_starjunk_fastmail_subdomains_mx_1" {
  name     = "mail"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
}

resource "cloudflare_record" "net_starjunk_fastmail_subdomains_mx_2" {
  name     = "mail"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
}

## SPF

moved {
  from = cloudflare_record.terraform_managed_resource_73ef1766328832460724a6e3e780a257
  to   = cloudflare_record.net_starjunk_spf
}

resource "cloudflare_record" "net_starjunk_spf" {
  name    = "starjunk.net"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:spf.messagingengine.com ?all"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

## DKIM

moved {
  from = cloudflare_record.terraform_managed_resource_96494382737d342503bf7f2f6aa83332
  to   = cloudflare_record.net_starjunk_fastmail_dkim_1
}

resource "cloudflare_record" "net_starjunk_fastmail_dkim_1" {
  name    = "fm1._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm1.starjunk.net.dkim.fmhosted.com"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

moved {
  from = cloudflare_record.terraform_managed_resource_1f45cbb0881abba9d2dff8072d550aae
  to   = cloudflare_record.net_starjunk_fastmail_dkim_2
}

resource "cloudflare_record" "net_starjunk_fastmail_dkim_2" {
  name    = "fm2._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm2.starjunk.net.dkim.fmhosted.com"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

moved {
  from = cloudflare_record.terraform_managed_resource_9714dc1aa362bbdf836abd7354b82252
  to   = cloudflare_record.net_starjunk_fastmail_dkim_3
}

resource "cloudflare_record" "net_starjunk_fastmail_dkim_3" {
  name    = "fm3._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm3.starjunk.net.dkim.fmhosted.com"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

## DMARC

moved {
  from = cloudflare_record.terraform_managed_resource_b80a3533e30542aa54abcac7747f8e41
  to   = cloudflare_record.net_starjunk_dmarc
}

resource "cloudflare_record" "net_starjunk_dmarc" {
  name    = "_dmarc"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=DMARC1; p=none; rua=mailto:11e643eadb6648a8b81fc11bcfe022f9@dmarc-reports.cloudflare.net"
  zone_id = "acff21a4b43636283cd28bd5c5bd44a5"
}

## Client email auto-discovery

resource "cloudflare_record" "net_starjunk_fastmail_smtp" {
  name     = "_submission._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 587
    priority = 0
    proto    = "_tcp"
    service  = "_submission"
    target   = "smtp.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_record" "net_starjunk_fastmail_imap" {
  name     = "_imap._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_imap"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "net_starjunk_fastmail_imaps" {
  name     = "_imaps._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 993
    priority = 0
    proto    = "_tcp"
    service  = "_imaps"
    target   = "imap.fastmail.com"
    weight   = 1
  }
}


resource "cloudflare_record" "net_starjunk_fastmail_pop3" {
  name     = "_pop3._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_pop3"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "net_starjunk_fastmail_pop3s" {
  name     = "_pop3s._tcp"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 995
    priority = 10
    proto    = "_tcp"
    service  = "_pop3s"
    target   = "pop.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_record" "net_starjunk_fastmail_jmap" {
  name     = "_jmap._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_jmap"
    target   = "api.fastmail.com"
    weight   = 1
  }
}

## Client CardDAV auto-discovery

resource "cloudflare_record" "net_starjunk_fastmail_carddav" {
  name     = "_carddav._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_carddav"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "net_starjunk_fastmail_carddavs" {
  name     = "_carddavs._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_carddavs"
    target   = "carddav.fastmail.com"
    weight   = 1
  }
}

## Client CalDAV auto-discovery

resource "cloudflare_record" "net_starjunk_fastmail_caldav" {
  name     = "_caldav._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_caldav"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "net_starjunk_fastmail_caldavs" {
  name     = "_caldavs._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "acff21a4b43636283cd28bd5c5bd44a5"
  data {
    name     = "starjunk.net"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_caldavs"
    target   = "caldav.fastmail.com"
    weight   = 1
  }
}
