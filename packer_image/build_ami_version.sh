#!/bin/bash

TF_DIR="../packer_task/terraform"

AMI_ID=$(terraform -chdir="$TF_DIR" output -raw ami_latest 2>/dev/null)


VERSION_FILE="version.txt"

if [ ! -f "$VERSION_FILE" ]; then
  echo "0" > "$VERSION_FILE"
fi

VERSION=$(cat "$VERSION_FILE")
NEW_VERSION=$((VERSION + 1))


if [[ "$AMI_ID" =~ ^ami- ]]; then	
  echo "Using AMI_ID from Terraform: $AMI_ID"
  echo "Building AMI version: $NEW_VERSION"
  packer build -var "ami_version=$NEW_VERSION" -var "source_ami=$AMI_ID"  packer.pkr.hcl
else
  echo "Build Default Version !"
  packer build packer.pkr.hcl
fi
