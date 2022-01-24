resource "aws_s3_bucket" "b" {
  bucket        = var.bucket
  acl           = var.acl
  force_destroy = var.force_destroy

  # cors_rule {
  #   allowed_headers = ["*"]
  #   allowed_methods = ["PUT", "POST"]
  #   allowed_origins = ["*"]
  #   expose_headers  = ["ETag"]
  #   max_age_seconds = 3000
  # }

}
