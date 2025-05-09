terraform {
  backend "s3" {
    bucket = "mygithub-action-test1"
    key    = "prod/green-blue"
    region = "eu-central-1"
  }
}

#data "terraform_remote_state" "green-blue" {
#  backend = "s3"
#
#  config = {
#    bucket = "mygithub-action-test1"
#    key    = "prod/green-blue"
#    region = "eu-central-1"
#  }
#}

resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.working.names[0]
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.working.names[1]
}


data "aws_availability_zones" "working" {}

data "aws_ami" "amazon_linux_latest" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "tag:Name"
    values = ["packer-example-Ansible*"]
  }
}
