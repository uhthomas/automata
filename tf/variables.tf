variable "account_id" {
  default = "cde22999fc6fe2ed5c9605561c508d29"
}

variable "zone" {
  default = "starjunk.net"
}

variable "zone_id" {
  default = "acff21a4b43636283cd28bd5c5bd44a5"
}

# overriden by Terraform Cloud
variable "cloudflare_api_token" {
  sensitive = true
}
