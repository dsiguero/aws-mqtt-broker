resource "aws_iot_topic_rule" "push_to_dynamo" {
  name        = "push_topic_data_to_dynamo"
  enabled     = true
  sql         = "SELECT * FROM '${var.iot_topic_name}'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    put_item {
      table_name = aws_dynamodb_table.iot_topic_data.id
    }
    role_arn = aws_iam_role.iot_push_to_dynamo.arn
  }

  # TODO: Error action
}
