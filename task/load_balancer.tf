#======= Load Balancer =======

module "aws_lb" {
  source                          = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//load_balancer"
  name                            = var.lb_name
  load_balancer_type              = var.lb_type
  security_groups                 = [module.security_group.sg_id]
  subnets                         = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  target_group_name               = var.tg_name
  tg_vpc_id                       = aws_default_vpc.default.id
  tg_port                         = var.tg_port
  tg_protocol                     = var.tg_protocol
  tg_deregistration_delay         = var.tg_deregistration_delay
  listener_load_balancer_arn      = module.aws_lb.lb_arn
  listener_port                   = var.listener_port
  listener_protocol               = var.listener_protocol
  default_action_type             = var.default_action_type
  default_action_target_group_arn = module.aws_lb.target_group_arn
}

