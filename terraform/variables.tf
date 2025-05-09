#======= REGION =======

variable "region" {}

#======= SSH KEY =======

variable "key_name" {}

#======= Load Balancer =======


variable "lb_name" {}
variable "lb_type" {}
variable "tg_name" {}
variable "tg_port" {}
variable "tg_protocol" {}
variable "tg_deregistration_delay" {}

variable "health_check_path" {}
variable "health_check_protocol" {}
variable "health_check_matcher" {}
variable "health_check_interval" {}
variable "health_check_timeout" {}
variable "healthy_threshold" {}
variable "unhealthy_threshold" {}

variable "listener_port" {}
variable "listener_protocol" {}
variable "default_action_type" {}


#======= Autoscaling Group =======


variable "versions" {}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}
variable "min_elb_capacity" {}
variable "health_check_type" {}


#======= Launch Template =======


variable "instance_type" {}
variable "lt_name" {}
variable "user_data" {}

variable "my_tags" {
  type = map(string)
  default = {
    Name  = "SERVER TEST FROM PACKER"
    Owner = "Edgar"
  }
}


#======= Autoscaling Policy =======


variable "autoscaling_policy_name" {}
variable "adjustment_type" {}
variable "cooldown" {}


#======= Security Group =======


variable "allow_ports" {}
variable "cidr_blocks" {}
variable "protocol" {}


#======= Cloudwatch Alarm =======


variable "comparison_operator_high" {}
variable "metric_name" {}
variable "namespace" {}
variable "statistic" {}
variable "threshold_high" {}
variable "period" {}
variable "comparison_operator_low" {}
variable "threshold_low" {}


#======= SNS Topic =======


variable "sns_name" {}
variable "sns_protocol" {}
variable "sns_endpoint" {}
