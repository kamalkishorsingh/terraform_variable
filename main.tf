#### Region Details ####
provider "aws" {
  region = "${var.aws_region}"
}

#### Module To Create ECS Cluster ####
module "ecs_local" {
  source            = "github.com/kamalkishorsingh/ecs_local"
  ecs_cluster       = "${var.ecs_cluster}"
}

#### ECR creation ####
module "ecr_repository" {
  source = "github.com/kamalkishorsingh/ecr_local"
  name   = "setup1/test1"
}
