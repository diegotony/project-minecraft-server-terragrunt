data "aws_iam_policy_document" "policy-s3-website" {
  statement {
    sid = "AddPerm"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${var.www_domain_name}/*",
    ]
  }
}

resource "aws_s3_bucket" "wwww" {
  bucket = var.bucket_name
  acl    = var.acl
  policy = data.aws_iam_policy_document.policy-s3-website.json

  website {
    // Here we tell S3 what to use when a request comes in to the root
    // ex. https://www.runatlantis.io
    index_document = "index.html"
    // The page to serve up if a request results in an error or a non-existing
    // page.
    error_document = "404.html"
  }

}
