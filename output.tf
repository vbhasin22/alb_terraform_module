output "alb_dns_name" {
    value = "${aws_alb.application_load_balancer.dns_name}"
}

output "alb_arn" {
    value = "${aws_alb.application_load_balancer.arn}"
}
