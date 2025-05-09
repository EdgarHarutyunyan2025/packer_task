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


variable "source_ami" {
  default = "ami-009082a6cd90ccd0e"
}


source "amazon-ebs" "example" {
  region        = "eu-central-1"
  source_ami = var.source_ami
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  ami_name      = "packer-ami-{{timestamp}}"
  tags = {
    Name = format("packer-example-Ansible-%s", var.ami_version)
  }
}

build {
  sources = [
    "source.amazon-ebs.example"
  ]

    provisioner "ansible" {
   playbook_file = "../packer_task/ansible/playbook.yml"
  }
}

