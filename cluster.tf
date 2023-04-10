## Cluster is created here ##
resource "aws_ecs_cluster" "web-cluster" {
  name = local.cluster_name
  setting {
    name = "containerInsights"
    value = local.container_insight
  }
}