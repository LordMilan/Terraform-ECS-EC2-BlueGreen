## Existing Load balancer ARN is mapped (Purpose: only for getting ALB DNS) ##
data "aws_lb" "existing" {
  arn  = local.alb_arn
}

## Use this for creating new ALB ##
# resource "aws_lb" "ecs-lb" {
#   name               = "test-ecs-lb"
#   load_balancer_type = "application"
#   internal           = false
#   subnets            = module.vpc.public_subnets
#   tags = {
#     "env"       = "dev"
#     "createdBy" = "milan"
#   }
#   security_groups = [aws_security_group.lb.id]
# }

# resource "aws_security_group" "lb" {
#   name   = "allow-all-lb"
#   vpc_id = local.vpc_id
#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     "env"       = "dev"
#     "createdBy" = "milan"
#   }
# }