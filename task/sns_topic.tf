#======== SNS TOPIC =======

module "sns_topic_subscription" {
  source    = "git::https://github.com/EdgarHarutyunyan2025/packer_module.git//sns_topic"
  name      = var.sns_name
  topic_arn = module.sns_topic_subscription.sns_topic_cpu_alerts_arn
  protocol  = var.sns_protocol
  endpoint  = var.sns_endpoint
}
