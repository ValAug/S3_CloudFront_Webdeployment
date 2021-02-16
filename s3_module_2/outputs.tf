# --- outputs module ---
output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution[*].domain_name
}

output "bucket_domain_name" {
  value = aws_s3_bucket.exos_bucket[*].bucket_domain_name
}