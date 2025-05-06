#====== AWS SG ======

module "security_group" {
  source      = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//sg"
  allow_ports = var.allow_ports
  cidr_blocks = var.cidr_blocks
  protocol    = var.protocol
}

