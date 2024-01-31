variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "security_group_ids" {}
variable "key_name" {}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "public_instance" {
  ami           = "ami-0a3c3a20c09d6f377"
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id

  security_groups = var.security_group_ids

  tags = {
    Name = "public_instance"
  }
}

resource "aws_instance" "private_instance" {
  ami           = "ami-0a3c3a20c09d6f377"
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = var.private_subnet_id

  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "private_instance"
  }
}

output "public_instance_public_ip" {
  value = aws_instance.public_instance.public_ip
}

output "public_instance_private_ip" {
  value = aws_instance.public_instance.private_ip
}

output "private_instance_private_ip" {
  value = aws_instance.private_instance.private_ip
}

