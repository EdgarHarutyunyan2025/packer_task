#!/bin/bash

TF_DIR="../terraform"

AMI_ID=$(terraform -chdir="$TF_DIR" output -raw ami_latest 2>/dev/null)


if [ -n "$GITHUB_SHA" ]; then
  NEW_VERSION="${GITHUB_SHA:0:7}"
else
  NEW_VERSION="local-build"
fi


if [[ "$AMI_ID" =~ ^ami- ]]; then	
  echo "Using AMI_ID from Terraform: $AMI_ID"
  echo "Building AMI version: $NEW_VERSION"
  packer build -var "ami_version=$NEW_VERSION" -var "source_ami=$AMI_ID"  packer.pkr.hcl
else
  echo "Build Default Version !"
  packer build -var "ami_version=$NEW_VERSION"   packer.pkr.hcl
fi
