/*--------------------------------------------------------------------------------------------------------*/
/*---------   ECS  Cluster  ------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------*/

resource "aws_ecs_cluster" "main" {
    name = "${var.ecs_cluster_name}"
}

/*--------------------------------------------------------------------------------------------------------*/
/*---------   AutoScaling Group  -------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------*/

resource "aws_autoscaling_group" "ecs_asg" {
    availability_zones = ["${var.asg_az01}"]
    name = "ECS ${var.ecs_cluster_name}"
    min_size = "${var.autoscale_min}"
    max_size = "${var.autoscale_max}"
    desired_capacity = "${var.autoscale_desired}"
    health_check_type = "EC2"
    launch_configuration = "${aws_launch_configuration.ecs_lc.name}"
    vpc_zone_identifier = ["subnet-09e70942"]

    tag  {
        key = "Name"
        value = "${var.asg_name}"
        propagate_at_launch = "true"
    }

}

/*--------------------------------------------------------------------------------------------------------*/
/*---------   Launch Configuration  ----------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------*/

resource "aws_launch_configuration" "ecs_lc" {
    name = "ECS ${var.ecs_cluster_name}"
    image_id = "${var.ecs_ami}"
    instance_type = "${var.instance_type}"
    security_groups = ["${aws_security_group.ecs_web_sg.id}","${aws_security_group.ecs_ssh_sg.id}","${aws_security_group.ecs_db_sg.id}","${aws_security_group.ecs_tomcat_sg.id}"]
    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
    key_name = "new_relic"
    associate_public_ip_address = true
    user_data = "${file("userdata/userdata.sh")}"
    root_block_device {
        volume_type = "gp2"
    volume_size = "30"
        delete_on_termination = true
    }
}

/*--------------------------------------------------------------------------------------------------------*/
/*---------   IAM Roles n Policies  ----------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------*/

resource "aws_iam_role" "ecs_host_role" {
    name = "ecs_host_role"
    assume_role_policy = "${file("policies/ecs-role.json")}"
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
    name = "ecs_instance_role_policy"
    policy = "${file("policies/ecs-instance-role-policy.json")}"
    role = "${aws_iam_role.ecs_host_role.id}"
}

resource "aws_iam_role" "ecs_service_role" {
    name = "ecs_service_role"
    assume_role_policy = "${file("policies/ecs-role.json")}"
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
    name = "ecs_service_role_policy"
    policy = "${file("policies/ecs-service-role-policy.json")}"
    role = "${aws_iam_role.ecs_service_role.id}"
}

resource "aws_iam_instance_profile" "ecs" {
    name = "ecs-instance-profile"
    path = "/"
    roles = ["${aws_iam_role.ecs_host_role.name}"]
}

#### ECR creation ####
module "ecr_repository" {
  source = "github.com/kamalkishorsingh/ecr_local"
  name   = "setup1/test1"
}

/*--------------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------*/
