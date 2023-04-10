locals {
  ## Key-pair name ##
  key_name                = "enrollible-msg-center-prod"
  
  ## Name for your cluster ##
  cluster_name            = "Tic-Tac-Cluster"
  container_insight       = "enabled"

  ##Values for ECR ##
  ecr_name_app            = lower(local.task_name_app)

  ## Values for VPC. VPC is not created by terraform here ##
  vpc_id                  = "vpc-a82893cd"
  public_subnets          = ["subnet-f8c8108f","subnet-066c975f","subnet-e47268cc"]
  
  ## Values for ALB, Listeners and target Groups. ALB and Listener is not created by Terraform here ##
   #ALB#
  alb_arn                 = "arn:aws:elasticloadbalancing:us-east-1:551804445178:loadbalancer/app/Halopay-BlueGreen-Production/f94dae1570ae78a9"
  alb_sg_id               = "sg-7b5d6f1e"
  alb_listener_arn        = "arn:aws:elasticloadbalancing:us-east-1:551804445178:listener/app/Halopay-BlueGreen-Production/f94dae1570ae78a9/46d3ac22a81d48e6"
   
   #TG#
  app_url                  = "prod-message.enrollible.com"

  ## Values for ASG and Capacity Provider##
  asg_configname          = "Tic-Tac"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1

  ecs_instance_type       = "t3a.micro"
 
   ## Values for ECS Task Definition ##
   #app#
  task_name_app            = "tic-tac-app"
  ecr_image_app            = aws_ecr_repository.app.repository_url
  cpu_app                  = 0
  memoryReservation_app    = 256

  log_driver              = "awslogs"
  network_mode            = "bridge"
  essential               = "true"
  awslogs-region          = "us-east-1"

  ## Values for ECS Service ##
  container_numbers_app    = 1
  container_port_app       = 3000

  ## local-exec script files names ##
   #Set up your script to pull code from Github repo, create .env files, etc for app in build-files folder##
   #Go to local-exec.tf and use your build files as required #
   

}
