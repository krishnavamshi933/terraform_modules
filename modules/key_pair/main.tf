resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

output "key_name" {
  value = aws_key_pair.my_key_pair.key_name
}

