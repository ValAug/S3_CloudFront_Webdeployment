# --- root - outputs
output "s3_info" {
  description = "s3 info"
  value       = [for x in module.static_web[*] : x]
}

output "dns" {
  description = "OAI"
  value       = [for x in module.dns[*] : x]
}