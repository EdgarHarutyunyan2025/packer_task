packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

variable "ami_version" {
  default = "0" 
}


source "amazon-ebs" "example" {
  region        = "eu-central-1"
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  ami_name      = "packer-ami-{{timestamp}}"

  source_ami_filter {
    filters = {
      name                = "packer-ami-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["self"]
    most_recent = true
  }


  tags = {
    Name = format("packer-example-commit->%s", var.ami_version)
  }
}

build {
  sources = [
    "source.amazon-ebs.example"
  ]

    provisioner "ansible" {
   playbook_file = "../ansible/playbook.yml"
  }
}

