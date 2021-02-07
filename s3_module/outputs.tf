# -- module outputs

output "s3_name" {
  description = "s3 bucket name"
  value       = [aws_s3_bucket.exos-web-bucket[*].bucket]
}