#!/usr/bin/bash
#shellcheck source=/dev/null


# Source all files in this directory
SCRIPT_DIR="$(dirname "$0")"
source "${SCRIPT_DIR}/print.sh"
source "${SCRIPT_DIR}/source-if-exists.sh"