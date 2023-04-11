## Cloudwatch log group for API is created ##
resource "aws_cloudwatch_log_group" "log_group_api" {
  name = local.log_group_name_api
  tags = {
    "env"       = "qa"
    "createdBy" = "milan"
  }
}

## Cloudwatch log group for API is created ##
resource "aws_cloudwatch_log_group" "log_group_ui" {
  name = local.log_group_name_ui
  tags = {
    "env"       = "qa"
    "createdBy" = "milan"
  }
}