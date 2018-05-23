
/*-----------------------------------------*/
/*----- ECS  Cluster ----------------------*/
/*-----------------------------------------*/

variable "ecs_cluster_name" {
    default = "FL-Dev"
}

/*-----------------------------------------*/
/*----- Auto Scaling Group ----------------*/
/*-----------------------------------------*/

variable "asg_az01" {
    default = "us-west-2"
}

/*-----------------------------------------*/

variable "autoscale_min" {
    default = "1"
}

/*-----------------------------------------*/

variable "autoscale_max" {
    default = "1"
}

/*-----------------------------------------*/

variable "autoscale_desired" {
    default = "1"
}

/*-----------------------------------------*/

variable "asg_name" {
    default = "FL_ECS_Development"
}

/*-----------------------------------------*/
/*----- Launch Configuration --------------*/
/*-----------------------------------------*/

variable "ecs_ami" {
    default = "ami-40ddb938"
}

/*-----------------------------------------*/

variable "instance_type" {
    default = "t2.small"
}

/*-----------------------------------------*/

#variable "key_path" {
#  default = "keys/dev-key.pub"
#} 
#variable "key_name"{
#  default = "new_relic"
#} 



###k test
#module "aws_alb" {
#  source          = "../alb"
#  public_key_path = "${var.key_path}"
#  keyname         = "${var.key_name}"
#}

/*-----------------------------------------*/
/*-----------------------------------------*/
/*-----------------------------------------*/


