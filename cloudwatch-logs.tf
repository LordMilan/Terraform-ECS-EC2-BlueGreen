## Cloudwatch log group for APP is created ##
resource "aws_cloudwatch_log_group" "log_group_app" {
  name = local.log_group_name_app
  tags = {
    "env"       = "prod"
    "createdBy" = "milan"
  }
}