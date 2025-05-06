provider "aws" {
  region = var.region
}

module "ssh_key" {
  source        = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//ssh_key"
  key_file_path = path.cwd
  ssh_key_name  = var.key_name
}

#module "security_group" {
#  source      = "./module/sg"
#  allow_ports = ["80", "22"]
#  cidr_blocks = ["0.0.0.0/0"]
#  protocol    = "tcp"
#}

#module "sns_topic_subscription" {
#  source    = "./module/sns_topic"
#  name      = "cpu-alerts-topic"
#  topic_arn = module.sns_topic_subscription.sns_topic_cpu_alerts_arn
#  protocol  = "email"
#  endpoint  = "edgar_harutyunyan_2025@bk.ru"
#}

#module "launch_template" {
#  source                 = "./module/launch_template"
#  name                   = "gren-blue-LT"
#  image_id               = data.aws_ami.amazon_linux_latest.id
#  instance_type          = "t2.micro"
#  ssh_key_name           = module.ssh_key.ssh_key_name
#  vpc_security_group_ids = [module.security_group.sg_id]
#  user_data              = "../web/user_data.sh"
#}
#
#module "autoscaling_group" {
#  source                  = "./module/autoscaling_group"
#  autoscaling_group_name  = "ASG V-1"
#  versions                = "1"
#  min_size                = 1
#  max_size                = 2
#  desired_capacity        = 1
#  min_elb_capacity        = 1
#  health_check_type       = "ELB"
#  vpc_zone_identifier     = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
#  target_group_arns       = [module.aws_lb.target_group_arn]
#  launch_template_id      = module.launch_template.launch_template_id
#  launch_template_version = module.launch_template.launch_template_version
#}

#module "aws_lb" {
#  source                          = "./module/load_balancer"
#  name                            = "green-blue-ALB"
#  load_balancer_type              = "application"
#  security_groups                 = [module.security_group.sg_id]
#  subnets                         = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
#  target_group_name               = "green-blue-tg"
#  tg_vpc_id                       = aws_default_vpc.default.id
#  tg_port                         = 80
#  tg_protocol                     = "HTTP"
#  tg_deregistration_delay         = 10
#  listener_load_balancer_arn      = module.aws_lb.lb_arn
#  listener_port                   = 80
#  listener_protocol               = "HTTP"
#  default_action_type             = "forward"
#  default_action_target_group_arn = module.aws_lb.target_group_arn
#}

#module "cloudwatch_cpu_alarm_high" {
#  source                          = "./module/cloudwatch_metric"
#  alarm_name                      = "CPU-Utilization-Above-80"
#  comparison_operator             = "GreaterThanOrEqualToThreshold"
#  evaluation_periods              = 2
#  metric_name                     = "CPUUtilization"
#  namespace                       = "AWS/EC2"
#  period                          = 60
#  statistic                       = "Average"
#  threshold                       = 80
#  alarm_description               = "Alarm when CPU exceeds 80%"
#  alarm_actions                   = [module.sns_topic_subscription.sns_topic_cpu_alerts_arn, module.autoscaling_policy_scale_up.scaleing_arn]
#  dimensions_AutoScalingGroupName = module.autoscaling_group.autoscaling_group_name
#
#}


#module "cloudwatch_cpu_alarm_low" {
#  source                          = "./module/cloudwatch_metric"
#  alarm_name                      = "CPU-Utilization-Below-20"
#  comparison_operator             = "LessThanOrEqualToThreshold"
#  evaluation_periods              = 2
#  metric_name                     = "CPUUtilization"
#  namespace                       = "AWS/EC2"
#  period                          = 60
#  statistic                       = "Average"
#  threshold                       = 20
#  alarm_description               = "Alarm when CPU drops below 20%"
#  alarm_actions                   = [module.sns_topic_subscription.sns_topic_cpu_alerts_arn, module.autoscaling_policy_scale_down.scaleing_arn]
#  dimensions_AutoScalingGroupName = module.autoscaling_group.autoscaling_group_name
#
#}

#module "autoscaling_policy_scale_up" {
#  source                        = "./module/autoscaling_group_policy"
#  autoscaling_policy_name       = "scale-up-policy"
#  scaling_adjustment            = 1
#  adjustment_type               = "ChangeInCapacity"
#  cooldown                      = 60
#  policy_autoscaling_group_name = module.autoscaling_group.autoscaling_group_name
#}
#
#
#module "autoscaling_policy_scale_down" {
#  source                        = "./module/autoscaling_group_policy"
#  autoscaling_policy_name       = "scale-down-policy"
#  scaling_adjustment            = -1
#  adjustment_type               = "ChangeInCapacity"
#  cooldown                      = 60
#  policy_autoscaling_group_name = module.autoscaling_group.autoscaling_group_name
#}
