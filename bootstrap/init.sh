#!/bin/bash
banner "Initializing Terraform for EC2 Module"
# Initialize Terraform in the ec2-module directory
terraform -chdir=/../terraform/deploy-ec2 init 
# Apply the Terraform configuration in the ec2-module directory
banner "Applying Terraform for EC2 Module"
# This will create the EC2 instance and other resources defined in the Terraform configuration
# Ensure you have the necessary permissions and configurations set up in your AWS environment
# The -auto-approve flag skips the interactive approval step
terraform -chdir=/../terraform/deploy-ec2 apply -auto-approve
