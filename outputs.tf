# --- root - outputs
output "s3_info" {
  description = "s3 info"
  value       = [for x in module.static_web_01[*] : x]
}

output "cdn" {
  description = "OAI"
  value       = [for x in module.static_web_02[*] : x]
}