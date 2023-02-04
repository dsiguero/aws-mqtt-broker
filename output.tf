data "aws_iot_endpoint" "endpoint" {
  endpoint_type = "iot:Data-ATS"
}

output "iot_certificate" {
  value = {
    cert        = aws_iot_certificate.cert.certificate_pem
    public_key  = aws_iot_certificate.cert.public_key
    private_key = aws_iot_certificate.cert.private_key
  }
  sensitive = true
}

output "aws_iot_root_ca_certificate" {
  value = data.http.aws_iot_root_ca_cert.response_body
}

output "iot_endpoint" {
  value = data.aws_iot_endpoint.endpoint.endpoint_address
}
