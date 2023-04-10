locals {
  #TG#
  tg_name_app              = "${local.task_name_app}-tg"

  ## Task Defn ##
  awslogs-group_app        = local.log_group_name_app

  ## Values for ECS Service ##
  container_name_app       = local.task_name_app

  ## Values for ASG and Capacity Provider##
  ec2-sg-name             = "${local.asg_configname}-ec2-sg"
  capacity_provider_name  = "${local.asg_configname}-CP"

  ## Values for ECS Service ##
  service_name_app         = "${local.task_name_app}-service"

  ## Values for CloudWatch Log Group Names ##
  log_group_name_app       = "/ecs/${local.task_name_app}"

  ## IAM ##
  iam_role_name_for_creating_EC2 = "ecs-instance-role-${local.asg_configname}"

  ## Container_definition File path. ##
  path                    = "container-definitions/container_defn.json"
  
  ## Docker Build ##
  docker_tag_app          = lower(local.task_name_app)
}