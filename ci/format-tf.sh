#!/usr/bin/env bash

set -euo pipefail

TF_VERSION=$(cat .terraform-version)

docker run -v "$(pwd)":/mnt \
    -w /mnt \
    "hashicorp/terraform:${TF_VERSION}" fmt
