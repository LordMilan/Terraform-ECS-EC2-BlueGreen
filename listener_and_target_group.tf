## API ##
## Target Group for API_BLUE is created here ##
resource "aws_lb_target_group" "api_blue" {
  name        = "${local.task_name_api}-blue"
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

 depends_on = [data.aws_lb.existing.arn]
}

## Listener Rule for API_BLUE is created here ##
resource "aws_lb_listener_rule" "api_blue" {
 depends_on = [data.aws_lb.existing.arn]
    lifecycle {
    create_before_destroy = true
  }
  listener_arn = local.alb_listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_blue.arn
  }
  condition {
    host_header {
      values = ["${local.api_url}"]
    }
  }
  # condition {
  #   path_pattern {
  #     values = ["/your_path"]
  #   }
  # }
}

## Target Group for API_GREEN is created here ##
resource "aws_lb_target_group" "api_green" {
  name        = "${local.task_name_api}-green"
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

depends_on = [data.aws_lb.existing.arn]
}


## UI ##
## Target Group for UI_BLUE is created here ##
resource "aws_lb_target_group" "ui_blue" {
  name        = "${local.task_name_ui}-blue"
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

 depends_on = [data.aws_lb.existing.arn]

}

## Listener Rule for UI_BLUE is created here ##
resource "aws_lb_listener_rule" "ui_blue" {
 depends_on = [data.aws_lb.existing.arn]
    lifecycle {
    create_before_destroy = true
  }
  listener_arn = local.alb_listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ui_blue.arn
  }
  condition {
    host_header {
      values = ["${local.ui_url}"]
    }
  }
  # condition {
  #   path_pattern {
  #     values = ["/your_path"]
  #   }
  # }
}

## Target Group for UI_GREEN is created here ##
resource "aws_lb_target_group" "ui_green" {
  name        = "${local.task_name_ui}-green"
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

depends_on = [data.aws_lb.existing.arn]
}