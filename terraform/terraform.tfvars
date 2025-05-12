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

health_check_path     = "/"
health_check_protocol = "HTTP"
health_check_matcher  = "200-399"
health_check_interval = 30
health_check_timeout  = 5
healthy_threshold     = 3
unhealthy_threshold   = 2

listener_port       = 80
listener_protocol   = "HTTP"
default_action_type = "forward"

#======= Autoscaling Group =======

versions          = 1
min_size          = 2
max_size          = 4
desired_capacity  = 2
min_elb_capacity  = 1
health_check_type = "ELB"

#======= Launch Template ======= 

instance_type = "t2.micro"
lt_name       = "LT-FOR-PACKER-TEST"
user_data     = "./user_data/user_data.sh"

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

sns_name     = "cpu-alert-topics"
sns_protocol = "email"
sns_endpoint = "edgar_harutyunyan_2025@bk.ru"
