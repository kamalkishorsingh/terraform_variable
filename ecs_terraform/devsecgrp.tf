/*--------------------------------------------------------*/

resource "aws_security_group" "ecs_alb_web_sg" {
  name = "ECS DEV ALB Web Security Group"
  vpc_id      = "vpc-d86ffca1"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 8080
      to_port = 8100
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  } 

  tags {
    Name = "ECS DEV ALB Web Security Group"
  }
}

/*--------------------------------------------------------*/

resource "aws_security_group" "ecs_web_sg" {
  name = "ECS DEV Web Security Group"
  vpc_id      = "vpc-d86ffca1"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      security_groups = ["sg-32f98e4d"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  } 

  tags {
    Name = "ECS DEV Web Security Group"
  }
}

/*--------------------------------------------------------*/

resource "aws_security_group" "ecs_ssh_sg" {
  name = "ECS DEV SSH Security Group"
  vpc_id = "vpc-d86ffca1"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "ECS DEV SSH Security Group"
  }
}

/*--------------------------------------------------------*/

resource "aws_security_group" "ecs_db_sg" {
  name = "ECS DEV DB Security Group"
  vpc_id = "vpc-d86ffca1"

  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "ECS DEV DB Security Group"
  }
}

/*--------------------------------------------------------*/

resource "aws_security_group" "ecs_tomcat_sg" {
  name = "ECS DEV Tomcat Security Group"
  vpc_id = "vpc-d86ffca1"

  ingress {
      from_port = 8080
      to_port = 8100
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      security_groups = ["sg-32f98e4d"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "ECS DEV Tomcat Security Group"
  }
}

/*--------------------------------------------------------*/

####  Key Pair
#module "ecs_key_pair" {
#  source          = "../../modules/key_pair"
#  public_key_path = "${var.key_path}"
#  keyname         = "${var.key_name}"
#}

resource "aws_key_pair" "aws" {
  key_name   = "ECS-aws"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrMvirYFBcrzE6mLr8I9E5ytHgkHuXlEV3Xf/o7jG4jIAMN0dSBMXBF9NvtA8qgMbxe/ZEEXSDqm6hWXvxM6Okcrxf2fZ0vfnOZfl/4zkYEJcfcvjMHrr2YjQHXw5R3fY9ugNc6nx+s9+zViH3oc1y9J9ksq3i8XrxvF9Lysj4l55rBhRfB7A9ZR3KrfDA5QnIpito+WZ52Ha3BJuH9txTlFdrsK/Lb0LqFWq46eAk1vvtacN3wrtk9hXlLMUkplfBA9oggHhrpxLHjSgdhSFA/ad3ywTvlUAoxl84kcv6a8hFWOgGD4/X8XF0hAa/yW5KV4dVTKoAzBBZhdhNXOg/ root@ansible"
}
