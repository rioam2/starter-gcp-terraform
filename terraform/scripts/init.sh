#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR > /dev/null
source env.sh

# Setup terraform backend state bucket
pushd ../backend 2>&1>/dev/null
terraform get
terraform init
# https://serverfault.com/a/989827
{ APPLY_RESPONSE=$(terraform apply -auto-approve 2>&1 | tee /dev/fd/3 | { grep -Poh 'Error [0-9]{3}' || true; } | { grep --color=never -Poh '[0-9]{3}' || true; } ); } 3>&1
case $APPLY_RESPONSE in
    "")
        echo "Successfully created terraform state bucket"
        ;;
    "409")
        echo "Warning: terraform state bucket already exists"
        echo "Importing existing state bucket"
        terraform import \
            google_storage_bucket.terraform-state-bucket \
            "$PROJECT_ID/$PROJECT_ID-terraform-state"
        terraform apply -auto-approve
        echo "Successfully imported terraform state bucket"
        ;;
    *)
        echo "Unknown error creating or refreshing terraform state bucket"
        exit 1
        ;;
esac
popd 2>&1>/dev/null

# Initialize main terraform configuration with GCS backend
pushd ../ 2>&1>/dev/null
terraform get
terraform init -backend-config="bucket=$PROJECT_ID-terraform-state"
popd 2>&1>/dev/null