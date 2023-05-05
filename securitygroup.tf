resource "aws_security_group" "security-group-vpc" {
  name_prefix = "security-group-vpc"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "tcp_port80in" {
  security_group_id = aws_security_group.security-group-vpc.id

  type             = "ingress"
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  from_port        = "80"
  to_port          = "80"


}

resource "aws_security_group_rule" "tcp_port22in" {
  security_group_id = aws_security_group.security-group-vpc.id

  type             = "ingress"
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  from_port        = "22"
  to_port          = "22"


}

resource "aws_security_group_rule" "tcp_portgeneral" {
  security_group_id = aws_security_group.security-group-vpc.id

  type             = "egress"
  protocol         = "all"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  from_port        = "0"
  to_port          = "65000"


}

resource "aws_security_group_rule" "tcp_port3306" {
  security_group_id = aws_security_group.security-group-vpc.id

  type             = "ingress"
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  from_port        = "3306"
  to_port          = "3306"


}