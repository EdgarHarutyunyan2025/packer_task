#======= REGION =======

region = "eu-central-1"

#======= SSH KEY =======

key_name = "packer"

#======= Load Balancer =======

lb_name                 = "ALB-FOR-PACKER-TEST"
lb_type                 = "application"
tg_name                 = "TG-FOR-PACKER-TEST"
tg_port                 = 80
tg_protocol             = "HTTP"
tg_deregistration_delay = 10
listener_port           = 80
listener_protocol       = "HTTP"
default_action_type     = "forward"

#======= Autoscaling Group =======

versions          = 1
min_size          = 1
max_size          = 2
desired_capacity  = 1
min_elb_capacity  = 1
health_check_type = "ELB"

#======= Launch Template ======= 

instance_type = "t2.micro"
user_data     = "./web/user_data.sh"
lt_name       = "LT-FOR-PACKER-TEST"

#======= Autoscaling Policy =======

autoscaling_policy_name = "scaling-policy"
adjustment_type         = "ChangeInCapacity"
cooldown                = 60

#======= Security Group =======

allow_ports = ["80", "22"]
cidr_blocks = ["0.0.0.0/0"]
protocol    = "tcp"

#======= Cloudwatch Alarm =======

comparison_operator_high = "GreaterThanOrEqualToThreshold"
metric_name              = "CPUUtilization"
namespace                = "AWS/EC2"
statistic                = "Average"
threshold_high           = 80
period                   = 60
comparison_operator_low  = "LessThanOrEqualToThreshold"
threshold_low            = 20

#======= SNS Topic =======

sns_name     = "cpu-alerts-topic"
sns_protocol = "email"
sns_endpoint = "edgar_harutyunyan_2025@bk.ru"
