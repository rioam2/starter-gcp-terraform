#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR > /dev/null
source env.sh

pushd ../ 2>&1>/dev/null
terraform apply -auto-approve
popd 2>&1>/dev/null