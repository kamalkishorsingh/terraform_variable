#### Variables for AWS ALB ####
variable "alb_is_internal" {
  description = "Boolean determining if the ALB is internal or externally facing."
  default     = false
}

variable "alb_name" {
  description = "The name of the ALB as will show in the AWS EC2 ELB console."
  default     = "test-alb"
}

variable "alb_security_groups" {
  description = "The security groups with which we associate the ALB."
  type        = "list"
  default     = ["sg-32f98e4d"]
}

variable "subnets" {
  description = "A list of subnets to associate with the ALB."
  type        = "list"
  default     = ["subnet-09e70942","subnet-6775b91e"]
}

#### Variables for AWS ALB TARGET GROUP ####
variable "backend_port" {
  description = "The port the service on the EC2 instances listen on."
  default     = 80
}

variable "backend_protocol" {
  description = "The protocol the backend service speaks."
  default     = "HTTP"
}

variable "vpc_id" {
  description = "VPC id where the ALB and other resources will be deployed."
  default     = "vpc-d86ffca1"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
#### Variables for Health Check ####

variable "health_check_interval" {
  description = "Interval in seconds on which the health check against backend hosts is tried."
  default     = 10
}

variable "health_check_path" {
  description = "The URL the ELB should use for health checks."
  default     = "/login"
}

variable "health_check_port" {
  description = "The port used by the health check if different from the traffic-port."
  default     = "80"
}

variable "health_check_timeout" {
  description = "Seconds to leave a health check waiting before terminating it and calling the check unhealthy."
  default     = 5
}

variable "health_check_matcher" {
  description = "The HTTP codes that are a success when checking TG health."
  default     = "200-299"
}

variable "target_type" {
  description = "The type of target that you must specify when registering targets with this target group."
  default     = "instance"
}

### Variables for AWS ALB LISTNER ####
variable "certificate_arn" {
  description = "The ARN of the SSL Certificate"
  default     = ""
}

variable "security_policy" {
  description = "The security policy if using HTTPS externally on the ALB. See"
  default     = "ELBSecurityPolicy-2016-08"
}
