## Task for ECS Cluster is defined here ##

## API ##
resource "aws_ecs_task_definition" "task-definition-api" {
  family                = local.task_name_api
  container_definitions = templatefile(local.path, {
    container_name    = local.task_name_api
    awslogs-group     = local.awslogs-group_api
    awslogs-region    = local.awslogs-region
    containerPort     = local.container_port_api
    cpu               = local.cpu_api
    memoryReservation = local.memoryReservation_api
    log_driver        = local.log_driver
    essential         = local.essential
    ecr_image         = "${aws_ecr_repository.api.repository_url}:${local.docker_tag_api}"
  })
  network_mode        = local.network_mode
  tags = {
    "env"       = "prod"
    "createdBy" = "milan"
  }
}

## UI ##
resource "aws_ecs_task_definition" "task-definition-ui" {
  family                = local.task_name_ui
  container_definitions = templatefile(local.path, {
    container_name    = local.task_name_ui
    awslogs-group     = local.awslogs-group_ui
    awslogs-region    = local.awslogs-region
    containerPort     = local.container_port_ui
    cpu               = local.cpu_ui
    memoryReservation = local.memoryReservation_ui
    log_driver        = local.log_driver
    essential         = local.essential
    ecr_image         = "${aws_ecr_repository.ui.repository_url}:${local.docker_tag_ui}"
  })
  network_mode        = local.network_mode
  tags = {
    "env"       = "prod"
    "createdBy" = "milan"
  }
}
