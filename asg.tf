## Most recent AMI is acquired from here ##
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

## Security Group for EC2 is created here ##
resource "aws_security_group" "ec2-sg" {
  name        = "allow-all-ec2"
  description = "allow all"
  vpc_id      = data.aws_vpc.existing.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = data.aws_lb.existing.security_groups
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "local.ec2-sg-name"
  }
}

## Launch Config for Autoscaling Group is Created here. ##
resource "aws_launch_configuration" "lc" {
  name          = local.asg_configname
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = local.ecs_instance_type
  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile        = aws_iam_instance_profile.ecs_service_role.name
  key_name                    = local.key_name
  security_groups             = [aws_security_group.ec2-sg.id]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
#sudo apt-get update
sudo echo "ECS_CLUSTER=${local.cluster_name}" >> /etc/ecs/ecs.config
EOF
}

## Autoscaling group is created here ##
resource "aws_autoscaling_group" "asg" {
  name                      = local.asg_configname
  launch_configuration      = aws_launch_configuration.lc.name
  min_size                  = local.min_size
  max_size                  = local.max_size
  desired_capacity          = local.desired_capacity
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = local.public_subnets

  #target_group_arns     = [aws_lb_target_group.lb_target_group_api.arn]
  protect_from_scale_in = false
  lifecycle {
    create_before_destroy = true
  }
}