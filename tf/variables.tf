variable "cloudflare_account_id" {
  default = "cde22999fc6fe2ed5c9605561c508d29"
}

variable "cloudflare_zone" {
  default = "starjunk.net"
}

# overriden by Terraform Cloud
variable "cloudflare_api_token" {
  sensitive = true
}
