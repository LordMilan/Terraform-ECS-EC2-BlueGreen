locals {
  ## Key-pair name ##
  key_name                = "enrollible-msg-center-prod"
  
  ## Name for your cluster ##
  cluster_name            = "Production-Enroll-Message-Center"
  container_insight       = "enabled"

  ##Values for ECR ##
  ecr_name_api            = lower(local.task_name_api)
  ecr_name_ui             = lower(local.task_name_ui)

  ## Values for VPC. VPC is not created by terraform here ##
  vpc_id                  = "vpc-a82893cd"
  public_subnets          = ["subnet-f8c8108f","subnet-066c975f","subnet-e47268cc"]
  
  ## Values for ALB, Listeners and target Groups. ALB and Listener is not created by Terraform here ##
   #ALB#
  alb_arn                 = "arn:aws:elasticloadbalancing:us-east-1:551804445178:loadbalancer/app/Halopay-BlueGreen-Production/f94dae1570ae78a9"
  alb_sg_id               = "sg-7b5d6f1e"
  alb_listener_arn        = "arn:aws:elasticloadbalancing:us-east-1:551804445178:listener/app/Halopay-BlueGreen-Production/f94dae1570ae78a9/46d3ac22a81d48e6"
   
   #TG#
  api_url                 = "prod-api-message.enrollible.com"
  ui_url                  = "prod-message.enrollible.com"

  ## Values for ASG and Capacity Provider##
  asg_configname          = "Production-msg-center"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1

  ecs_instance_type       = "t3a.micro"
 
   ## Values for ECS Task Definition ##
   #API#
  task_name_api           = "prod-enroll-msg-center-API"
  ecr_image_api           = aws_ecr_repository.api.repository_url
  cpu_api                 = 0
  memoryReservation_api   = 256

   #UI#
  task_name_ui            = "prod-enroll-msg-center-UI"
  ecr_image_ui            = aws_ecr_repository.ui.repository_url
  cpu_ui                  = 0
  memoryReservation_ui    = 256

   #Common for API and UI#
  log_driver              = "awslogs"
  network_mode            = "bridge"
  essential               = "true"
  awslogs-region          = "us-east-1"

  ## Values for ECS Service ##
  container_numbers_api   = 1
  container_port_api      = 80
  
  container_numbers_ui    = 1
  container_port_ui       = 80

  ## local-exec script files names ##
   #Set up your script to pull code from Github repo, create .env files, etc for ui and api in build-files folder##
   #Go to local-exec.tf and use your build files as required #
   

}
