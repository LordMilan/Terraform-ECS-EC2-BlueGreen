
## Get ALB DBS ##
output "alb_dns" {
   value = data.aws_lb.existing.dns_name
 }

## Get UI link ##
output "UI_URL" {
   value = "${local.ui_url}"
 }

 ## GET UI Task Definition ARN ##
 output "UI_Task-Definition-ARN" {
   value = "${aws_ecs_task_definition.task-definition-ui.arn}"
 }

  ## GET UI applicationName ##
 output "UI_applicationName" {
   value = "${aws_codedeploy_deployment_group.UI[1].app_name}"
 }

  ## GET UI DeploymentGroup Name ##
 output "UI_DeploymentGroupName" {
   value = "${aws_codedeploy_deployment_group.UI[1].deployment_group_name}"
 }

 ## Get API link ##
output "API_URL" {
   value = "${local.api_url}"
 }

 ## GET API Task Definition ARN ##
 output "API_Task-Definition-ARN" {
   value = "${aws_ecs_task_definition.task-definition-api.arn}"
 }

  ## GET API applicationName ##
 output "API_applicationName" {
   value = "${aws_codedeploy_deployment_group.API[1].app_name}"
 }

  ## GET API DeploymentGroup Name ##
 output "API_DeploymentGroupName" {
   value = "${aws_codedeploy_deployment_group.API[1].deployment_group_name}"
 }
# output "alb_dns" {
#   value = aws_lb.test-lb.dns_name
# }

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "public_subnets" {
#   value = module.vpc.public_subnets
# }

# output "igw_id" {
#   value = module.vpc.igw_id
# }

