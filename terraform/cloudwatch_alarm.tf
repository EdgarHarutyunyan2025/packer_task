#======= Cloudwatch Alarm =======

module "cloudwatch_cpu_alarm_high" {
  source                          = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//cloudwatch_metric"
  alarm_name                      = "CPU-Utilization-Above-80"
  comparison_operator             = var.comparison_operator_high
  evaluation_periods              = 2
  metric_name                     = var.metric_name
  namespace                       = var.namespace
  period                          = var.period
  statistic                       = var.statistic
  threshold                       = var.threshold_high
  alarm_description               = "Alarm when CPU exceeds 80%"
  alarm_actions                   = [module.sns_topic_subscription.sns_topic_cpu_alerts_arn, module.autoscaling_policy_scale_up.scaleing_arn]
  dimensions_AutoScalingGroupName = module.autoscaling_group.autoscaling_group_name

}


module "cloudwatch_cpu_alarm_low" {
  source                          = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//cloudwatch_metric"
  alarm_name                      = "CPU-Utilization-Below-20"
  comparison_operator             = var.comparison_operator_low
  evaluation_periods              = 2
  metric_name                     = var.metric_name
  namespace                       = var.namespace
  period                          = var.period
  statistic                       = var.statistic
  threshold                       = var.threshold_low
  alarm_description               = "Alarm when CPU drops below 20%"
  alarm_actions                   = [module.sns_topic_subscription.sns_topic_cpu_alerts_arn, module.autoscaling_policy_scale_down.scaleing_arn]
  dimensions_AutoScalingGroupName = module.autoscaling_group.autoscaling_group_name

}

