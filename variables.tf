variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "aws_iot_ca_cert_url" {
  type        = string
  default     = "https://www.amazontrust.com/repository/AmazonRootCA1.pem"
  description = "URL for the AWS IoT Root CA Certificate"
}

variable "iot_thing_name" {}

variable "iot_loglevel" {
  type    = string
  default = "WARN"
  validation {
    condition     = contains(["DEBUG", "INFO", "ERROR", "WARN", "DISABLED"], var.iot_loglevel)
    error_message = "${var.iot_loglevel} is not a valid log level."
  }
}

variable "iot_topic_name" {
  description = "Name of the topic (allows wildcards) for the query that gets data into DynamoDB"
  type = string
}
