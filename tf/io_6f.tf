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

resource "cloudflare_record" "terraform_managed_resource_d4603ee3dc9485a7575eb40b3711c016" {
  name    = "fm1._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm1.6f.io.dkim.fmhosted.com"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_57c23353922764ea967d7d15613aa166" {
  name    = "fm2._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm2.6f.io.dkim.fmhosted.com"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_38fb6498048e4298798cae0e158e81ef" {
  name    = "fm3._domainkey"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "fm3.6f.io.dkim.fmhosted.com"
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

resource "cloudflare_record" "terraform_managed_resource_cc96197e58585c64ea10efb0d7332fa6" {
  name     = "6f.io"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_0b63b8d61f82dab8391bb00ebb633fa3" {
  name     = "6f.io"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  zone_id  = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_5ca8e9920a633edeb723b3320ceac23b" {
  name    = "6f.io"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:spf.messagingengine.com ?all"
  zone_id = "897af3a08a43f0b90fc93479c2b8ef41"
}

resource "cloudflare_record" "terraform_managed_resource_0cc8b3fbade586b0ec4b1af14c505ae5" {
  name    = "_dmarc"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=DMARC1;  p=none; rua=mailto:852672a62a5c41bc8f2eb9ea9a7e37ed@dmarc-reports.cloudflare.net"
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
