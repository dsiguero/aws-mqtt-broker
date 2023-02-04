# aws-mqtt-broker


### Check connection with AWS IoT endpoint
```
mosquitto_pub -h "${IOT_HOST}" -p 8883 \
  --key /mosquitto/certs/private.key \
  --cert /mosquitto/certs/cert.crt \
  --cafile /mosquitto/ca_certificates/rootCA.pem \
  -t "${IOT_TOPIC}" -m '{"hello" : "test"}' -i myclientid -d
```

### Get IoT and Root CA certificates from Terraform

Use `terraform output -raw <output_key>` to retrieve individual keys from the Terraform outputs.

Example:

```sh
# get the AWS IoT CA Root certificate
terraform output -raw aws_iot_root_ca_certificate

# get the PEM certificate
terraform output -raw iot_certificate.cert

# get the public key
terraform output -raw iot_certificate.public_key

# get the private key
terraform output -raw iot_certificate.private_key
```

Check the available outputs [here](output.md).
