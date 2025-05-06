#======= Autoscaling Group ========

module "autoscaling_group" {
  source                  = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//autoscaling_group"
  autoscaling_group_name  = "ASG V-${var.versions}"
  versions                = var.versions
  min_size                = var.min_size
  max_size                = var.max_size
  desired_capacity        = var.desired_capacity
  min_elb_capacity        = var.min_elb_capacity
  health_check_type       = var.health_check_type
  vpc_zone_identifier     = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  target_group_arns       = [module.aws_lb.target_group_arn]
  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_version
}

