
## Get ALB DBS ##
output "alb_dns" {
   value = data.aws_lb.existing.dns_name
 }

## Get UI link ##
output "app" {
   value = "${local.app_url}"
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

