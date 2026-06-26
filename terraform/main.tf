terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "~> 0.16"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}
variable "ts_api-key" {}
variable "ts_tailnet-id" {}

provider "tailscale" {
  api_key = var.ts_api-key
  tailnet = var.ts_tailnet-id
}

resource "tailscale_tailnet_key" "this" {
  description   = var.key_description
  reusable      = false
  ephemeral     = true
  preauthorized = true
  expiry        = var.key_expiry
}

resource "local_sensitive_file" "tskey" {
  content         = "ts-key: \"${tailscale_tailnet_key.this.key}\"\n"
  filename        = "${path.module}/../ts-key.yaml"
  file_permission = "0600"
}
