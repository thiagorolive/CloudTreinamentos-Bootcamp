#
# criação do gateway
#
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet-gateway"

  }
}
#
# criação da tabela de roteamento publico
#
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id

  }

  tags = {
    Name = "public-route-table"
  }
  depends_on = [aws_internet_gateway.gw]
}
#
# associação da tabela de roteamento publico nas Subnets AeB
#
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.public.id
}