## Executing shell script to build image and push to ECR via Null Resource ##
## APP ##
resource "null_resource" "build_app" {
 provisioner "local-exec" {
    command = <<EOT
aws ecr get-login-password --region ${local.awslogs-region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${local.awslogs-region}.amazonaws.com
sudo git clone git@github.com:LordMilan/tick-tac-toe.git
cd tick-tac-toe
sudo docker build -t ${local.docker_tag_app} .
sudo docker tag ${local.docker_tag_app}:latest ${local.ecr_image_app}:${local.docker_tag_app}
sudo docker push ${local.ecr_image_app}:${local.docker_tag_app}
    EOT
    interpreter = ["/bin/bash", "-c"]
    working_dir = "./build-files"
  }
}
