# ec2 instances
resource "aws_instance" "public_servers" {
  count         = 2
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "server-${count.index + 1}"
  }
}

# jumpserver