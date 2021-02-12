# --- outputs module ---

output "identity_path" {
  description = "OAI"
  value = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
}