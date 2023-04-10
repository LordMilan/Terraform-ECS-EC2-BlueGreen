
## Target Group for APP is created here ##
resource "aws_lb_target_group" "lb_target_group_app" {
  name        = local.tg_name_app
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
}

## Listener Rule for app is created here ##
resource "aws_lb_listener_rule" "app" {
 depends_on = [local.alb_listener_arn]
    lifecycle {
    create_before_destroy = true
  }
  listener_arn = local.alb_listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group_app.arn
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