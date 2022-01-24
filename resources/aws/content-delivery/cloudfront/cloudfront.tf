resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = var.origin_name

    s3_origin_config {
      origin_access_identity = var.origin_access_identity
    }
  }

  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = var.comment
  default_root_object = var.default_root_object

  aliases = var.aliases
  default_cache_behavior {
    allowed_methods  = var.default_cache_behavior-allowed_methods
    cached_methods   = var.default_cache_behavior-cached_methods
    target_origin_id = var.origin_name

    forwarded_values {
      query_string = var.default_cache_behavior-query_string

      cookies {
        forward = var.default_cache_behavior-cookies-forward
      }
    }

    viewer_protocol_policy = var.default_cache_behavior-viewer_protocol_policy
    min_ttl                = var.default_cache_behavior-min_ttl
    default_ttl            = var.default_cache_behavior-default_ttl
    max_ttl                = var.default_cache_behavior-max_ttl
  }


  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = var.restrictions-geo_restriction-restriction_type
      locations        = var.restrictions-geo_restriction-locations
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.viewer_certificate_cloudfront_default_certificate
  }
}