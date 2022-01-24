variable "bucket_regional_domain_name" {

}

variable "origin_name" {

}

variable "origin_access_identity" {

}

variable "enabled" {
  default = true
}

variable "is_ipv6_enabled" {
  default = true
}

variable "comment" {
  default = "Some comment"
}

variable "default_root_object" {
  default = "index.html"
}

variable "default_cache_behavior-allowed_methods" {
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "default_cache_behavior-cached_methods" {
  default = ["GET", "HEAD"]

}

variable "default_cache_behavior-query_string" {
  default = false
}

variable "default_cache_behavior-cookies-forward" {
  default = "none"
}


variable "default_cache_behavior-viewer_protocol_policy" {
  default = "allow-all"

}

variable "default_cache_behavior-min_ttl" {
  default = 0
}

variable "default_cache_behavior-default_ttl" {
  default = 3600
}


variable "default_cache_behavior-max_ttl" {
  default = 86400
}



variable "price_class" {
  default = "PriceClass_200"
}

variable "restrictions-geo_restriction-restriction_type" {
  default = "whitelist"
}


variable "restrictions-geo_restriction-locations" {
  type    = list(any)
  default = ["US", "CA", "GB", "DE"]
}

variable "viewer_certificate_cloudfront_default_certificate" {
  default = true
}

variable "aliases" {
  type = list(any)
}