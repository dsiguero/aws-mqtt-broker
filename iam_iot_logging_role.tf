data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "logging_role_policydoc" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutMetricFilter",
      "logs:PutRetentionPolicy",
      "logs:GetLoggingOptions",
      "logs:SetLoggingOptions",
      "logs:SetV2LoggingOptions",
      "logs:GetV2LoggingOptions",
      "logs:SetV2LoggingLevels",
      "logs:ListV2LoggingLevels",
      "logs:DeleteV2LoggingLevels"
    ]
    resources = [
      # "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group::${log-stream}:",
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group::/aws/iot/"
    ]
  }
}

data "aws_iam_policy_document" "assume_role_policydoc" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["iot.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iot_logging" {
  name               = "iot_cloudwatch_logs"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policydoc.json

  inline_policy {
    name   = "iot-logs-to-cloudwatch"
    policy = data.aws_iam_policy_document.logging_role_policydoc.json
  }
}