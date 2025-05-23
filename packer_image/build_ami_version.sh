#!/bin/bash


if [ -n "$GITHUB_SHA" ]; then
  NEW_VERSION="${GITHUB_SHA:0:7}"
else
  NEW_VERSION="local-build"
fi

AMI_ID=$(aws ec2 describe-images \
  --owners self \
  --region "eu-central-1" \
  --filters "Name=state,Values=available" \
  --query "Images | sort_by(@, &CreationDate) | [-1].ImageId" \
  --output text)


if [[ "$AMI_ID" == "None" || -z "$AMI_ID" ]]; then
  echo "❌ AMI not found. Build Default AMI VERSION."
  packer init default_packer_ami.pkr.hcl
  packer build -var="ami_version=$NEW_VERSION"  default_packer_ami.pkr.hcl
else
  echo "✅ AMI found: Update $AMI_ID "
  packer init new_packer_ami.pkr.hcl
  packer build -var="ami_version=$NEW_VERSION"  new_packer_ami.pkr.hcl
fi

