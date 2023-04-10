# Note:
- Existing VPC, ECR, Application Load balancer and Key-Pair is used. New ones are not created. So, you need to provide their values in locals.tf.

# Summary:
This project creates a simple infrastructure using Terraform and AWS cloud provider. It consists of:
- Script to pull API and UI code, build and push to ECR repository
- Terraform code which creates:
    1. ECS Cluster
    2. Autoscaling Group and Capacity Provider which is added to ECS cluster
    3. Creates ECS task definition for API and UI
    4. Creates ECS service for API and UI
    5. Creates Target Groups and maps domain to Target Group in ALB Listner


## How to create the infrastructure?
This example implies that you have already AWS account & CLI, Docker and Terraform CLI installed.
1. Clone and cd into this repository
2. Set your desired customized value in locals.tf
3. terraform init
4. terraform plan
5. terraform apply

Note: it can take about 5 minutes to provision all resources.
## How to delete the infrastructure?
1. Terminate instances
2. Run `terraform destroy`