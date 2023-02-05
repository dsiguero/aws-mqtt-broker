resource "aws_dynamodb_table" "iot_topic_data" {
  name = "iot-topic-data"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 2
  hash_key       = "date"
  range_key      = "time"

  attribute {
    name = "date"
    type = "S"
  }

  attribute {
    name = "time"
    type = "S"
  }
}

data "aws_iam_policy_document" "push_to_dynamo_policydoc" {
  statement {
    effect = "Allow"
    actions = [ "dynamodb:PutItem" ]
    resources = [ aws_dynamodb_table.iot_topic_data.arn ]
  }
}

resource "aws_iam_role" "iot_push_to_dynamo" {
  name               = "iot_push_to_dynamodb"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policydoc.json

  inline_policy {
    name   = "iot-topic-data-to-dynamodb"
    policy = data.aws_iam_policy_document.push_to_dynamo_policydoc.json
  }
}
