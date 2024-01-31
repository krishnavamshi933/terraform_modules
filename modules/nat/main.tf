variable "public_subnet_id" {}
variable "private_subnet_id" {}

resource "aws_eip" "nat" {
  instance = null
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id
}

resource "aws_route" "private_nat_route" {
  route_table_id         = var.private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

output "nat_public_ip" {
  value = aws_eip.nat.public_ip
}
