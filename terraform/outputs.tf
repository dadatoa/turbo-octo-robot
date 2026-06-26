output "tskey_file" {
  description = "Path to the generated YAML file containing the Tailscale auth key."
  value       = local_sensitive_file.tskey.filename
}

output "key_expires_at" {
  description = "Expiry timestamp of the generated Tailscale auth key."
  value       = tailscale_tailnet_key.this.expires_at
}
