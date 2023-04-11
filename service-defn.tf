## Service for ECS Cluster(API) is defined here ##
## API ##
resource "aws_ecs_service" "service_api" {
  name            = local.service_name_api
  cluster         = aws_ecs_cluster.web-cluster.id
  task_definition = aws_ecs_task_definition.task-definition-api.arn
  desired_count   = local.container_numbers_api
  scheduling_strategy  = "REPLICA"

  deployment_controller {
    type = "CODE_DEPLOY"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.api_blue.arn
    container_name   = local.container_name_api
    container_port   = local.container_port_api
  }
  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }
}


## Service for ECS Cluster(UI) is defined here ##
## UI ##
resource "aws_ecs_service" "service_ui" {
  name            = local.service_name_ui
  cluster         = aws_ecs_cluster.web-cluster.id
  task_definition = aws_ecs_task_definition.task-definition-ui.arn
  desired_count   = local.container_numbers_ui
  scheduling_strategy  = "REPLICA"

  deployment_controller {
    type = "CODE_DEPLOY"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.ui_blue.arn
    container_name   = local.container_name_ui
    container_port   = local.container_port_ui
  }
  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }
}
