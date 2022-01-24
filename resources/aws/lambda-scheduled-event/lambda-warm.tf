data "aws_lambda_function" "lambda_function" {
  function_name = var.lambda-name
}

resource "aws_cloudwatch_event_rule" "event-rule" {
  name                = "warm-${var.lambda-name}"
  description         = "Fires every ${var.rate}"
  schedule_expression = "rate(${var.rate})"
}

resource "aws_cloudwatch_event_target" "check_foo_every_five_minutes" {
  rule      = aws_cloudwatch_event_rule.event-rule.name
  target_id = "${var.lambda-name}-target-id"
  arn       = data.aws_lambda_function.lambda_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda-name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event-rule.arn
}