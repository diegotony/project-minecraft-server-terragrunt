data "archive_file" "lambda_file" {
  type = "zip"

  source_dir  = var.source_dir
  output_path = var.output_path
}

resource "aws_s3_bucket_object" "lambda_s3_object" {
  bucket = var.bucket
  key    = var.function_name
  source = data.archive_file.lambda_file.output_path
  etag   = filemd5(data.archive_file.lambda_file.output_path)

}

resource "aws_lambda_function" "lambda" {
  function_name    = var.function_name
  s3_bucket        = var.bucket
  s3_key           = aws_s3_bucket_object.lambda_s3_object.key
  runtime          = var.runtime
  handler          = var.handler
  source_code_hash = data.archive_file.lambda_file.output_base64sha256
  role             = aws_iam_role.lambda_exec.arn
  environment {
    variables = var.environment
  }
}

resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/${aws_lambda_function.lambda.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

