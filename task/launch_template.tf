#======= Launch Template =======

module "launch_template" {
  source                 = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//launch_template"
  name                   = var.lt_name
  image_id               = data.aws_ami.amazon_linux_latest.id
  instance_type          = var.instance_type
  ssh_key_name           = module.ssh_key.ssh_key_name
  vpc_security_group_ids = [module.security_group.sg_id]
  user_data              = var.user_data
}
