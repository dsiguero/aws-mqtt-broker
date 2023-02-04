#!/usr/bin/env bash

set -euo pipefail

docker run -v "$(pwd)":/data \
    -e DELIM_START='<!-- BEGIN_TF_DOCS -->' \
    -e DELIM_CLOSE='<!-- END_TF_DOCS -->' \
    cytopia/terraform-docs:0.16.0 \
    terraform-docs-replace-012 --sort-by required md README.md
