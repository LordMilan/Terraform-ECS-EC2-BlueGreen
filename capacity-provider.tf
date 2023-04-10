## Capacity Provider is added to ECS Cluster here ##
resource "aws_ecs_cluster_capacity_providers" "cluster-cp" {
  cluster_name = local.cluster_name
  capacity_providers = [aws_ecs_capacity_provider.cp.name]
  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.cp.name
  }
}


## Capacity Provider is associated with an autoscaling group here ##
resource "aws_ecs_capacity_provider" "cp" {
  name        = local.capacity_provider_name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 96
    }
  }
}
