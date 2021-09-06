# starter-gcp-terraform

Template repository for creating projects on Google Cloud with Terraform.

# Usage

1. Setup a new Google Cloud project [here](https://console.cloud.google.com/cloud-resource-manager).
   1. Make note of your project id
2. Initialize template code:
   1. Run `terraform/scripts/init.sh` to setup your environment
   2. Define your resources in the `terraform/*` directory
   3. Run `terraform/scripts/deploy.sh` to deploy your project's infrastructure
