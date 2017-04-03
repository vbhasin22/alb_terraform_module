provider "aws" {
  region = "${var.aws_region}"
}

#alb resource
resource "aws_alb" "application_load_balancer" {
  name = "${coalesce(var.alb_name, format("%s-%s-%s-elb", var.app_name, var.app_type, var.app_env))}"
  security_groups = ["${split(",", var.security_groups)}"]
  subnets = ["${split(",", var.subnets)}"]
  internal = "${var.is_internal}"
  idle_timeout = "${var.idle_timeout}"

  access_logs {
    bucket = "${var.s3_bucket}"
    prefix = "${var.s3_prefix}"
    enabled = true
  }

  tags {
    Stack = "${var.stack}"
    OwnerContact = "${var.Ownercontact}"
  }
}

#alb target group
resource "aws_alb_target_group" "application" {
  name = "${var.app_name}-${var.app_type}-${var.app_env}-targetgroup"
  port = "${var.app_port}"
  protocol = "${var.app_protocol}"
  vpc_id   = "${var.vpc_id}"
  deregistration_delay = "${var.deregistration_delay}"

  health_check {
    interval = "${var.health_check_interval}"
    path = "${var.health_check_path}"
    port = "${var.app_port}"
    protocol = "${var.health_check_protocol}"
    timeout = "${var.health_check_timeout}"
    healthy_threshold = "${var.health_check_healthy_threshold}"
    unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
    matcher = "${var.health_check_matcher}"
  }

  tags {
    Stack = "${var.stack}"
    OwnerContact = "${var.Ownercontact}"
  }
}

#alb listener http
resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.application_load_balancer.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.application.arn}"
    type = "forward"
  }
}

#alb listener https
resource "aws_alb_listener" "https" {
  load_balancer_arn = "${aws_alb.application_load_balancer.arn}"
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2015-05"
  certificate_arn = "${var.ssl_certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.application.arn}"
    type = "forward"
  }
}

#alb listener rule http
resource "aws_alb_listener_rule" "http" {
  listener_arn = "${aws_alb_listener.http.arn}"
  priority = "${var.priority_http}"

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.application.arn}"
  }

  condition {
    field = "path-pattern"
    values = "${var.paths_http}"
  }
}

#alb listener rule https
resource "aws_alb_listener_rule" "https" {
  listener_arn = "${aws_alb_listener.https.arn}"
  priority = "${var.priority_https}"

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.application.arn}"
  }

  condition {
    field = "path-pattern"
    values = "${var.paths_https}"
  }
}
