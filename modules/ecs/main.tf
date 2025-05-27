resource "aws_ecs_cluster" "main" {
  name = var.app_name
  tags = {
    Name        = var.app_name
    Environment = var.environment
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.app_name}-sg"
  description = "Security group for ECS cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
