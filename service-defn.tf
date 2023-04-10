## Service for ECS Cluster(APP) is defined here ##
## APP ##

resource "aws_ecs_service" "ecs_service" {
  name            = local.service_name_app
  cluster         = aws_ecs_cluster.web-cluster.id
  task_definition = aws_ecs_task_definition.task-definition-app.arn
  desired_count   = local.container_numbers_app
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group_app.arn
    container_name   = local.container_name_app
    container_port   = local.container_port_app
  }
  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }
}