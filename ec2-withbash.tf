# Imagem mais recente do ubuntu
#

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}
#
# ElasticIP
# 
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.instance_a.id
  allocation_id = aws_eip.instance_a.id

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip_association" "eip_assoc2" {
  instance_id   = aws_instance.instance_b.id
  allocation_id = aws_eip.instance_b.id

  depends_on = [aws_internet_gateway.gw]
}


#
# servers AeB
#
resource "aws_instance" "instance_a" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  user_data              = file("scripts/script-init.sh")
  subnet_id              = aws_subnet.subnet_a.id
  vpc_security_group_ids = [aws_security_group.security-group-vpc.id]
  depends_on             = [aws_internet_gateway.gw]
  tags = {
    Name        = "instance-a"
    environment = var.env
    provisioner = "terraform"
  }
}

resource "aws_instance" "instance_b" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  user_data              = file("scripts/script-init.sh")
  subnet_id              = aws_subnet.subnet_b.id
  vpc_security_group_ids = [aws_security_group.security-group-vpc.id]
  depends_on             = [aws_internet_gateway.gw]
  tags = {
    Name        = "instance-b"
    environment = var.env
    provisioner = "terraform"
  }
}
#
# associação do Elastic_IP
#
resource "aws_eip" "instance_a" {
  vpc = true

  tags = {
    Name = "eip_a"
  }
}

resource "aws_eip" "instance_b" {
  vpc = true

  tags = {
    Name = "eip_b"
  }
}

#
# snapshot do volume do ec2
#

# data "aws_instance" "server" {
#   instance_id = aws_instance.server.id
# }

# data "aws_ebs_volume" "volume_bootcamp" {
#   filter {
#     name   = "attachment.instance-id"
#     values = [data.aws_instance.server.id]
#   }
# }

# resource "aws_ebs_snapshot" "snapshot_bootcamp" {
#   volume_id = data.aws_ebs_volume.volume_bootcamp.id
#   tags = {
#     Name = "snapshot_bootcamp"
#   }
# }
