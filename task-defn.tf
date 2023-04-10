## Task for ECS Cluster is defined here ##
## APP ##
resource "aws_ecs_task_definition" "task-definition-app" {
  family                = local.task_name_app
  container_definitions = templatefile(local.path, {
    container_name    = local.task_name_app
    awslogs-group     = local.awslogs-group_app
    awslogs-region    = local.awslogs-region
    containerPort     = local.container_port_app
    cpu               = local.cpu_app
    memoryReservation = local.memoryReservation_app
    log_driver        = local.log_driver
    essential         = local.essential
    ecr_image         = "${aws_ecr_repository.app.repository_url}:${local.docker_tag_app}"
  })
  network_mode        = local.network_mode
  tags = {
    "env"       = "prod"
    "createdBy" = "milan"
  }
}