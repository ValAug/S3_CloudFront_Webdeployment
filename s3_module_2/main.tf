# -- module main --

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "test origin access"
  
}

resource "random_string" "bucket_rs" {
  count   = var.s3_count
  length  = 4
  special = false
  upper   = false

}

resource "aws_s3_bucket" "exos_bucket" {
  count  = var.s3_count
  bucket = join("-", ["exos-bucket", random_string.bucket_rs[count.index].result])
  acl    = "public-read-write"
}

locals {
  s3_origin_id = "exosweborigin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  count = var.s3_count
  origin {
    
    domain_name = aws_s3_bucket.exos_bucket[count.index].bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }

  }


  enabled             = true
  is_ipv6_enabled     = true
  comment             = "exos S3 CloudFront distribution"
  default_root_object = "index.html"



  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "exos_test_env"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
 }