#!/bin/bash

echo "Which cloud provider would you like to use?"
echo "Options: azure, gcp, aws"
read -rp "Enter your choice: " provider

# Convert input to lowercase (optional, to make it case-insensitive)
provider=$(echo "$provider" | tr '[:upper:]' '[:lower:]')

case "$provider" in
    azure)
        echo "You chose Azure. Launching Azure deployment..."
        # Add Azure-specific commands here
        ;;
    gcp)
        echo "You chose GCP. Launching Google Cloud deployment..."
        # Add GCP-specific commands here
        ;;
    aws)
        echo "You chose AWS. Launching AWS deployment..."
        # Add AWS-specific commands here
        ;;
    *)
        echo "Invalid option. Please choose from: azure, gcp, aws"
        ;;
esac