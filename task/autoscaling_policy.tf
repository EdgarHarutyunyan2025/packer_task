#======== Autoscaling Policy ========

module "autoscaling_policy_scale_up" {
  source                        = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//autoscaling_group_policy"
  autoscaling_policy_name       = "${var.autoscaling_policy_name}-up"
  scaling_adjustment            = 1
  adjustment_type               = var.adjustment_type
  cooldown                      = var.cooldown
  policy_autoscaling_group_name = module.autoscaling_group.autoscaling_group_name
}


module "autoscaling_policy_scale_down" {
  source                        = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//autoscaling_group_policy"
  autoscaling_policy_name       = "${var.autoscaling_policy_name}-down"
  scaling_adjustment            = -1
  adjustment_type               = var.adjustment_type
  cooldown                      = var.cooldown
  policy_autoscaling_group_name = module.autoscaling_group.autoscaling_group_name
}

