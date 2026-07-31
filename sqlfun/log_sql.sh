#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/settings.conf"

# shellcheck disable=SC2034
start_datetime="$(date '+%Y-%m-%d %H:%M:%S')"

