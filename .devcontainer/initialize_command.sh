#!/usr/bin/env bash

set -euo pipefail

echo "Performing a pre-checks before starting the dev container..."

ENV_FILE_PATH=".env"

if [ ! -f ${ENV_FILE_PATH} ] && [ -f ${ENV_FILE_PATH}.example ]; then
  echo "${ENV_FILE_PATH} does not exist. Creating it from ${ENV_FILE_PATH}.example."
  cp ${ENV_FILE_PATH}.example ${ENV_FILE_PATH}
fi

echo "...Pre-checks complete."
