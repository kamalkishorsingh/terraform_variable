resource "aws_ecs_service" "qa-ecs-service" {
  	name            = "${var.ecs-service-name}"
  	iam_role        = "${var.ecs-service-role-arn}"
  	cluster         = "${aws_ecs_cluster.qa-ecs-cluster.id}"
  	task_definition = "${aws_ecs_task_definition.qa-sample-definition.arn}"
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = "${var.ecs-target-group-arn}"
    	container_port    = 8080
    	container_name    = "simple-app"
	}
}
