output "bucket_regional_domain_name" {
  value = aws_s3_bucket.b.bucket_regional_domain_name
}

output "bucket" {
  value = aws_s3_bucket.b.bucket
}

output "arn" {
  value = aws_s3_bucket.b.arn
}