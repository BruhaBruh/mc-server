#!/bin/bash

set -e
set -o pipefail

apk add --no-cache -U \
  coreutils \
  curl iputils \
  jq
