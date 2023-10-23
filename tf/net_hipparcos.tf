resource "cloudflare_zone" "terraform_managed_resource_994692a638e9a8c4ae552a9e6dacb609" {
  account_id = "cde22999fc6fe2ed5c9605561c508d29"
  paused     = false
  plan       = "free"
  type       = "full"
  zone       = "hipparcos.net"
}

resource "cloudflare_record" "terraform_managed_resource_f7e7d606ea20e6a29c7e268c7715b74e" {
  name    = "hipparcos.net"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "100::"
  zone_id = "994692a638e9a8c4ae552a9e6dacb609"
}

# Fastmail
#
# https://www.fastmail.help/hc/en-us/articles/360060591153-Manual-DNS-configuration

resource "cloudflare_record" "terraform_managed_resource_9a01f57d2026a498ba69c6e55b25e001" {
  name     = "hipparcos.net"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
}

resource "cloudflare_record" "terraform_managed_resource_80a3b9351b70b6c09085329d03c355ab" {
  name     = "hipparcos.net"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
}

## Subdomain Mail

resource "cloudflare_record" "terraform_managed_resource_6bc996fbe9aa45078bf34305ad1b6f50" {
  name     = "*"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
}

resource "cloudflare_record" "terraform_managed_resource_8ce67ae8f8520e22b15daf5af245c5a3" {
  name     = "*"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
}

## Webmail Login Portal

resource "cloudflare_record" "terraform_managed_resource_29190c165c26da1d92c7858b74dab4d8" {
  name    = "mail"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "mail.fastmail.com"
  zone_id = "994692a638e9a8c4ae552a9e6dacb609"
}

### Allow mail at subdomains

resource "cloudflare_record" "terraform_managed_resource_8ff6114729e0ccc038188c7349c44f93" {
  name     = "mail"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
}

resource "cloudflare_record" "terraform_managed_resource_5d0d2e817cffc85eba40bec17a6fd6d9" {
  name     = "mail"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
}

## SPF

resource "cloudflare_record" "terraform_managed_resource_bf76208b81e67ff68b70a57bae94226f" {
  name    = "hipparcos.net"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:spf.messagingengine.com ?all"
  zone_id = "994692a638e9a8c4ae552a9e6dacb609"
}

## DKIM

resource "cloudflare_record" "terraform_managed_resource_b861a72f5625b9e60f2610c85b08501b" {
  name    = "fm1._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm1.hipparcos.net.dkim.fmhosted.com"
  zone_id = "994692a638e9a8c4ae552a9e6dacb609"
}

resource "cloudflare_record" "terraform_managed_resource_c3754ac605e72da047aebe471cdff4f7" {
  name    = "fm2._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm2.hipparcos.net.dkim.fmhosted.com"
  zone_id = "994692a638e9a8c4ae552a9e6dacb609"
}

resource "cloudflare_record" "terraform_managed_resource_be51b7f396ff3f68451c87e41ba9274f" {
  name    = "fm3._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm3.hipparcos.net.dkim.fmhosted.com"
  zone_id = "994692a638e9a8c4ae552a9e6dacb609"
}

## DMARC

resource "cloudflare_record" "terraform_managed_resource_6364516621a4bfade37617e417b0c213" {
  name    = "_dmarc"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "\"v=DMARC1;  p=none; rua=mailto:95506e4bcd13411f9c0dadfe1c2e7f85@dmarc-reports.cloudflare.net\""
  zone_id = "994692a638e9a8c4ae552a9e6dacb609"
}

## Client email auto-discovery

resource "cloudflare_record" "terraform_managed_resource_4c64611f8756ae7715ece35782342f0b" {
  name     = "_submission._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 587
    priority = 0
    proto    = "_tcp"
    service  = "_submission"
    target   = "smtp.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_record" "terraform_managed_resource_88cc2e5ec9a93a44c7be32e9bb0a1323" {
  name     = "_imap._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_imap"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "terraform_managed_resource_daeb805f3d837ea3f13aedf23359f116" {
  name     = "_imaps._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 993
    priority = 0
    proto    = "_tcp"
    service  = "_imaps"
    target   = "imap.fastmail.com"
    weight   = 1
  }
}


resource "cloudflare_record" "terraform_managed_resource_4332f8e9dccbfaf72fcccb92a1bdff5b" {
  name     = "_pop3._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_pop3"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "terraform_managed_resource_0eeba5fa76750609ba994cfd0047a4fa" {
  name     = "_pop3s._tcp"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 995
    priority = 10
    proto    = "_tcp"
    service  = "_pop3s"
    target   = "pop.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_record" "terraform_managed_resource_363ab94d5d812b41b1d99238b8c55496" {
  name     = "_jmap._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_jmap"
    target   = "api.fastmail.com"
    weight   = 1
  }
}

## Client CardDAV auto-discovery

resource "cloudflare_record" "terraform_managed_resource_7482e7a3b939e94a17168e781bbc401a" {
  name     = "_carddav._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_carddav"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "terraform_managed_resource_6dbef040592eb401babb8ab4ebca1415" {
  name     = "_carddavs._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_carddavs"
    target   = "carddav.fastmail.com"
    weight   = 1
  }
}

## Client CalDAV auto-discovery

resource "cloudflare_record" "terraform_managed_resource_3237bb1db82965b3796074caea68e40e" {
  name     = "_caldav._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 0
    priority = 0
    proto    = "_tcp"
    service  = "_caldav"
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_record" "terraform_managed_resource_e7733a293362560c1279c946fa4a1da2" {
  name     = "_caldavs._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = "994692a638e9a8c4ae552a9e6dacb609"
  data {
    name     = "hipparcos.net"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_caldavs"
    target   = "caldav.fastmail.com"
    weight   = 1
  }
}
