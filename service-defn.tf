## Service for ECS Cluster(APP) is defined here ##
## APP ##
resource "aws_ecs_service" "service_app" {
  name            = local.service_name_app
  cluster         = aws_ecs_cluster.web-cluster.id
  task_definition = aws_ecs_task_definition.task-definition-app.arn
  desired_count   = local.container_numbers_app
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group_app.arn
    container_name   = local.container_name_app
    container_port   = local.container_port_app
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_target_group.lb_target_group_app]
}
