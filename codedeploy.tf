resource "aws_codedeploy_app" "main" {
  compute_platform = "ECS"
  name             = "Deploy-${local.task_name_app}"
}

// AWS Codedeploy Group for each codedeploy app created
resource "aws_codedeploy_deployment_group" "main" {
  count = 1
  app_name               = aws_codedeploy_app.main.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = "deployment-group-${local.task_name_app}"
  service_role_arn       = aws_iam_role.codedeploy_service.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 0
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = local.cluster_name
    service_name = aws_ecs_service.ecs_service.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [
          local.alb_listener_arn]
      }

      target_group {
        name = aws_lb_target_group.blue.name
      }

      target_group {
        name = aws_lb_target_group.green.name
      }

    }
  }

  lifecycle {
    ignore_changes = [blue_green_deployment_config]
  }
}