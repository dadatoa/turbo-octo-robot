variable "tailscale_oauth_client_id" {
  description = "Tailscale OAuth client ID. Can also be set via TAILSCALE_OAUTH_CLIENT_ID env var."
  type        = string
  sensitive   = true
  default     = null
}

variable "tailscale_oauth_client_secret" {
  description = "Tailscale OAuth client secret. Can also be set via TAILSCALE_OAUTH_CLIENT_SECRET env var."
  type        = string
  sensitive   = true
  default     = null
}

variable "tailscale_tailnet" {
  description = "Tailscale tailnet name (e.g. example.com). Use '-' for the default tailnet. Can also be set via TAILSCALE_TAILNET env var."
  type        = string
  default     = "-"
}

variable "key_description" {
  description = "Description for the generated Tailscale auth key."
  type        = string
  default     = "Terraform-managed auth key"
}

variable "key_expiry" {
  description = "Expiry duration for the auth key in seconds. Defaults to 3600 (1 hour)."
  type        = number
  default     = 3600
}
