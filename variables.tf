#Stack Variables
variable "aws_region" {
  description = "AWS where alb will be created"
  default = "us-east-1"
}

variable "app_type" {
  description = "Application type (web or app) for the stack"
}

variable "app_name" {
  description = "Application Name for the stack"
}

variable "app_env" {
  description = "Application env for the stack"
}

#Alb Variables
variable "alb_name" {
  description = "This is the name of the alb"
}

variable "security_groups" {
  description = "security groups for the alb"
}

variable "subnets" {
  description = "subnets for the alb"
}

variable "is_internal" {
  description = "bool to represent alb provision schema"
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
}

variable "s3_bucket" {
  description = "The name of the s3 bucket to send alb logs to"
}

variable "s3_prefix" {
  description = "The S3 bucket prefix. Logs are stored in the root if not configured"
}

#Alb target group Variables
variable "app_port" {
  description = "The port on which targets receive traffic, unless overridden when registering a specific target"
}

variable "app_protocol" {
  description = "The protocol to use for routing traffic to the targets"
}

variable "vpc_id" {
  description = "The identifier of the VPC in which to create the target group"
}

variable "deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds. Default 30 seconds."
}

variable "health_check_path" {
  description = "The destination for the health check request. Default /."
}

variable "health_check_protocol" {
  description = "The protocol to use to connect with the target. Defaults to HTTP."
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check. Defaults to 5 seconds."
}

variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to 5."
}

variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy. Defaults to 2."
}

variable "health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target. Defaults to 200. You can specify multiple values (for example, "200,202") or a range of values (for example, "200-299")."
}

#Alb listener Variables
variable "ssl_certificate_arn" {
  description = "Arn for the ssl certificate to attach to the https alb listener"
}

#Alb listener rule Variables
variable "priority_http" {
  description = "The priority for the rule. A listener can't have multiple rules with the same priority, for the http listener"
}

variable "priority_https" {
  description = "The priority for the rule. A listener can't have multiple rules with the same priority, for the https listener"
}

variable "paths_http" {
  description = "The path patterns to match for the http listener"
}

variable "paths_https" {
  description = "The path patterns to match for the https listener"
}

#Tagging Variables
variable "stack" {
  description = "Name of the stack"
}

variable "Ownercontact" {
  description = "Owner contact for the stack"
}
