
## Target Group for APP_BLUE is created here ##
resource "aws_lb_target_group" "blue" {
  name        = "${local.tg_name_app}-blue"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.existing.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }

  depends_on = [aws_alb.existing]
}

## Listener Rule for APP_BLUE is created here ##
resource "aws_lb_listener_rule" "app" {
 depends_on = [local.alb_listener_arn]
    lifecycle {
    create_before_destroy = true
  }
  listener_arn = local.alb_listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
  condition {
    host_header {
      values = ["${local.app_url}"]
    }
  }
  # condition {
  #   path_pattern {
  #     values = ["/your_path"]
  #   }
  # }
}

## Target Group for APP_GREEN is created here ##
resource "aws_lb_target_group" "green" {
  name        = "${local.tg_name_app}-green"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.existing.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }

  depends_on = [aws_alb.existing]
}