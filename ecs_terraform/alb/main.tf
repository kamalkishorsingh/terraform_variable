resource "aws_alb" "main" {
  name            = "${var.alb_name}"
  subnets         = ["${var.subnets}"]
  security_groups = ["${var.alb_security_groups}"]
  internal        = "${var.alb_is_internal}"
  tags            = "${merge(var.tags, map("Name", var.alb_name))}"
}

resource "aws_alb_target_group" "target_group" {
  name                 = "${var.alb_name}-tg"
  port                 = "${var.backend_port}"
  protocol             = "${upper(var.backend_protocol)}"
  vpc_id               = "${var.vpc_id}"

  health_check {
    interval            = "${var.health_check_interval}"
    path                = "${var.health_check_path}"
    port                = "${var.health_check_port}"
    timeout             = "${var.health_check_timeout}"
    protocol            = "${var.backend_protocol}"
    matcher             = "${var.health_check_matcher}"
  }

  target_type = "${var.target_type}"

  tags = "${merge(var.tags, map("Name", "${var.alb_name}-tg"))}"

  depends_on = ["aws_alb.main"]
}

resource "aws_alb_listener" "frontend_http" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    type             = "forward"
  }

  depends_on = ["aws_alb.main"]
}

#resource "aws_alb_listener" "frontend_https" {
#  load_balancer_arn = "${aws_alb.main.arn}"
#  port              = "443"
#  protocol          = "HTTPS"
#  certificate_arn   = "${var.certificate_arn}"
#  ssl_policy        = "${var.security_policy}"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.target_group.id}"
#    type             = "forward"
#  }

#  depends_on = ["aws_alb.main"]
#}

resource "aws_alb_listener_rule" "test_service_listener" {
  listener_arn = "${aws_alb_listener.frontend_http.arn}"
  priority = 100

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
  }

  condition {
    field = "path-pattern"
    values = ["/"]
  }
  depends_on = ["aws_alb_target_group.target_group"]
}
