#!/usr/bin/env bash
pushd terraform
    terraform init
    terraform apply --auto-approve
popd
# This script initializes and applies a Terraform configuration in the 'terraform' directory.
# It first changes the current directory to 'terraform', then runs 'terraform init' to initialize the configuration,
# and finally runs 'terraform apply --auto-approve' to apply the configuration without prompting for confirmation.
# The 'popd' command returns to the previous directory.
# The script is useful for automating the deployment of infrastructure as code using Terraform.
# It is important to ensure that the Terraform configuration files are correctly set up before running this script.
