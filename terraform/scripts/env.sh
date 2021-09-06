#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR > /dev/null

echo "Loading environment variables from .env file"

# Source provided environment variables from .env
ENVFILE="../../.env"
if test -f "$ENVFILE"; then
    source $ENVFILE
    export $(cut -d= -f1 $ENVFILE)
fi

if [[ -z "$PROJECT_ID" ]]; then
    read -p "+ PROJECT_ID=" PROJECT_ID
    echo "PROJECT_ID=$PROJECT_ID" >> $ENVFILE
fi

if [[ -z "$REGION" ]]; then
    read -p "+ REGION=" REGION
    echo "REGION=$REGION" >> $ENVFILE
fi

# Alias input variables for Terraform
export TF_VAR_project_id=$PROJECT_ID
export TF_VAR_region=$REGION

echo "Environment variables loaded"
