variable "vpc_id" {}

resource "aws_security_group" "instance_sg" {
  vpc_id      = var.vpc_id
  name        = "instance_sg"
  description = "Security group for instances allowing ports 22 and 80"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_security_group" "private_instance_sg" {
  vpc_id      = var.vpc_id
  name        = "private_instance_sg"
  description = "Security group for private instance allowing SSH from public instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${module.instances.public_instance_private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_sg_id" {
  value = aws_security_group.instance_sg.id
}

output "private_instance_sg_id" {
  value = aws_security_group.private_instance_sg.id
}
