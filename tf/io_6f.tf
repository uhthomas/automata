resource "cloudflare_zone" "terraform_managed_resource_897af3a08a43f0b90fc93479c2b8ef41" {
  account_id = "cde22999fc6fe2ed5c9605561c508d29"
  paused     = false
  plan       = "enterprise"
  type       = "full"
  zone       = "6f.io"
}

resource "cloudflare_record" "terraform_managed_resource_db96d0c2bd7972625be5edfb3c5bffe9" {
  name    = "6f.io"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "6f-io.pages.dev"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_8e25b2b378da0648ba369b9dba940837" {
  name    = "conf"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "kipp.mahalo.starjunk.net"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_6e857bdca1445a64f3c51bb5b599a57a" {
  name    = "dev"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "io-6f-dev.mahalo.starjunk.net"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_c7c7aac067224716e99e76df79f93d93" {
  name    = "k2"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "kipp2.mahalo.starjunk.net"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_efe7fe55ec455b87e990804d1c4f43ec" {
  name    = "kipp"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "kipp-final.pages.dev"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_1714d68e80dc91eee44cbae49aab342b" {
  name    = "kipp.dev"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "kipp-dev.mahalo.starjunk.net"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_3c986ffe0ab0b93f0612a798366c9841" {
  name    = "llama"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "public.r2.dev"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_513a2faf949a87be72061144680663ab" {
  name    = "r2"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "public.r2.dev"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_66997b850ba0f52317fd67e950b2db74" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "6f.io"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_84bc001ab67b45685c199d3e624adcdb" {
  name    = "google._domainkey"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh1gK6OrYk7W+Qu+kWIQRyRlyFTHBuzZqVe0tTgIkg27ngR6LNiiecO5AKxYwc39c+KcQm7bL9qWz/K0CTWkfbdy74grzfd33Ezb+0cQjWyJrh8M7eEVdMRD4w1FxI+ZQvMeyPQo3hdGHi7NVqlV9xd9RwoEeq7bUFRNZ3Uqh82VwgwrCRPt6VQw4E04/fCLYGzqGzkhyJN14Y63yERDyS7kPtFVoZWbsoMZhv5GTcikXkfBBo/irMvZqS+zrzR75DyyWAfWOwHxJ8TPGVWzrtOBtuItHSayT8tNKxv1vWJshSkpuoRs0g8ZXXc3PbGkB6KiSoa8lHoYAJgvLXdM5fQIDAQAB"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}


# Fastmail
#
# https://www.fastmail.help/hc/en-us/articles/360060591153-Manual-DNS-configuration

moved {
  from = cloudflare_record.terraform_managed_resource_0b63b8d61f82dab8391bb00ebb633fa3
  to   = cloudflare_record.io_6f_fastmail_mx_1
}

resource "cloudflare_record" "io_6f_fastmail_mx_1" {
  name     = "6f.io"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
}

moved {
  from = cloudflare_record.terraform_managed_resource_cc96197e58585c64ea10efb0d7332fa6
  to   = cloudflare_record.io_6f_fastmail_mx_2
}

resource "cloudflare_record" "io_6f_fastmail_mx_2" {
  name     = "6f.io"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
}

## Subdomain Mail

resource "cloudflare_record" "io_6f_fastmail_mail_mx_1" {
  name     = "*"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "io_6f_fastmail_mail_mx_2" {
  name     = "*"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
}

## Webmail Login Portal

resource "cloudflare_record" "io_6f_fastmail_webmail_login_portal" {
  name    = "mail"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "mail.fastmail.com"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

### Allow mail at subdomains

resource "cloudflare_record" "io_6f_fastmail_subdomains_mx_1" {
  name     = "mail"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "io_6f_fastmail_subdomains_mx_2" {
  name     = "mail"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
}

## SPF

moved {
  from = cloudflare_record.terraform_managed_resource_5ca8e9920a633edeb723b3320ceac23b
  to = cloudflare_record.io_6f_spf
}

resource "cloudflare_record" "io_6f_spf" {
  name    = "6f.io"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:spf.messagingengine.com ?all"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

## DKIM

moved {
  from = cloudflare_record.terraform_managed_resource_d4603ee3dc9485a7575eb40b3711c016
  to   = cloudflare_record.io_6f_fastmail_dkim_1
}

resource "cloudflare_record" "io_6f_fastmail_dkim_1" {
  name    = "fm1._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm1.6f.io.dkim.fmhosted.com"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

moved {
  from = cloudflare_record.terraform_managed_resource_57c23353922764ea967d7d15613aa166
  to   = cloudflare_record.io_6f_fastmail_dkim_2
}

resource "cloudflare_record" "io_6f_fastmail_dkim_2" {
  name    = "fm2._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm2.6f.io.dkim.fmhosted.com"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

moved {
  from = cloudflare_record.terraform_managed_resource_38fb6498048e4298798cae0e158e81ef
  to   = cloudflare_record.io_6f_fastmail_dkim_3
}

resource "cloudflare_record" "io_6f_fastmail_dkim_3" {
  name    = "fm3._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm3.6f.io.dkim.fmhosted.com"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

## DMARC

moved {
  from = cloudflare_record.terraform_managed_resource_0cc8b3fbade586b0ec4b1af14c505ae5
  to   = cloudflare_record.io_6f_dmarc
}

resource "cloudflare_record" "io_6f_dmarc" {
  name    = "_dmarc"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=DMARC1; p=none; rua=mailto:852672a62a5c41bc8f2eb9ea9a7e37ed@dmarc-reports.cloudflare.net"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

## Client email auto-discovery

resource "cloudflare_record" "io_6f_fastmail_smtp" {
  name     = "_submission._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 587
    priority = 0
    proto    = "_tcp"
    service  = "_submission"
    target   = "smtp.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_record" "io_6f_fastmail_imap" {
  name     = "_imap._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_imap"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "io_6f_fastmail_imaps" {
  name     = "_imaps._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 993
    priority = 0
    proto    = "_tcp"
    service  = "_imaps"
    target   = "imap.fastmail.com"
    weight   = 1
  }
}


resource "cloudflare_record" "io_6f_fastmail_pop3" {
  name     = "_pop3._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_pop3"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "io_6f_fastmail_pop3s" {
  name     = "_pop3s._tcp"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 995
    priority = 10
    proto    = "_tcp"
    service  = "_pop3s"
    target   = "pop.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_record" "io_6f_fastmail_jmap" {
  name     = "_jmap._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_jmap"
    target   = "api.fastmail.com"
    weight   = 1
  }
}

## Client CardDAV auto-discovery

resource "cloudflare_record" "io_6f_fastmail_carddav" {
  name     = "_carddav._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_carddav"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "io_6f_fastmail_carddavs" {
  name     = "_carddavs._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_carddavs"
    target   = "carddav.fastmail.com"
    weight   = 1
  }
}

## Client CalDAV auto-discovery

resource "cloudflare_record" "io_6f_fastmail_caldav" {
  name     = "_caldav._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_caldav"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "io_6f_fastmail_caldavs" {
  name     = "_caldavs._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
  data {
    name     = "6f.io"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_caldavs"
    target   = "caldav.fastmail.com"
    weight   = 1
  }
}
