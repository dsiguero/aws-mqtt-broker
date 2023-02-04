resource "aws_iot_thing" "home_assistant" {
  name = var.iot_thing_name
}

resource "aws_iot_certificate" "cert" {
    active = true
}

data "aws_iam_policy_document" "iot_thing" {
  statement {
    effect = "Allow"
    actions = [ "iot:*" ]
    resources = [ "arn:aws:s3:::*" ]
  }
}

resource "aws_iot_policy" "pubsub" {
  name = "AllowAll"
  policy = data.aws_iam_policy_document.iot_thing.json
}

resource "aws_iot_policy_attachment" "policy_attachment" {
  policy = aws_iot_policy.pubsub.name
  target = aws_iot_certificate.cert.arn
}

resource "aws_iot_logging_options" "logging_config" {
  default_log_level = var.iot_loglevel
  role_arn          = aws_iam_role.iot_logging.arn
}

data "http" "aws_iot_root_ca_cert" {
  url = var.aws_iot_ca_cert_url
}
