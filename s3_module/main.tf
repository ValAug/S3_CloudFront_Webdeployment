# --- s3_module main file

resource "random_string" "bucket_rs" {
  count   = var.s3_count
  length  = 4
  special = false
  upper   = false
  
}
resource "aws_s3_bucket" "exos_bucket" {
  count = var.s3_count
  bucket = join("-", ["exos-bucket", random_string.bucket_rs[count.index].result])
  acl    = "private"
}

resource "aws_cloudfront_distribution" "exos_distribution" {
  count = var.s3_count
  origin {
    
    custom_origin_config {
      http_port = "80"
      https_port = "443"
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]

    }
    
    domain_name = aws_s3_bucket.exos_bucket[count.index].bucket_regional_domain_name
    origin_id = "exos_distribution"

  }

  enabled = true
  default_root_object = "index.html"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress = true
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "exos_distribution"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

  

    
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }

  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}






# locals {
#   s3_origin_id = "exosweborigin"
# }

# resource "aws_cloudfront_distribution" "s3_distribution" {
#   origin {
#     count = var.s3_count
#     domain_name = aws_s3_bucket.exos-bucket.*.bucket_regional_domain_name[*]
#     origin_id   = local.s3_origin_id

#   }


# enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Sayon S3 CloudFront distribution"
#   default_root_object = "index.html"



#   default_cache_behavior {
#     allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "allow-all"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   # Cache behavior with precedence 0
#   ordered_cache_behavior {
#     path_pattern     = "/content/immutable/*"
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false
#       headers      = ["Origin"]

#       cookies {
#         forward = "none"
#       }
#     }

#     min_ttl                = 0
#     default_ttl            = 86400
#     max_ttl                = 31536000
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#   }

#   # Cache behavior with precedence 1
#   ordered_cache_behavior {
#     path_pattern     = "/content/*"
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = true

#       cookies {
#         forward = "none"
#       }
#     }

#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#   }

#   price_class = "PriceClass_200"

#   restrictions {
#     geo_restriction {
#       restriction_type = "whitelist"
#       locations        = ["US", "CA", "GB", "DE"]
#     }
#   }

#   tags = {
#     Environment = "sayon_test_env"
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }