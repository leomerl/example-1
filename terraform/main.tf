# vpc
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "example-01"
  }
}

# subnets
resource "aws_subnets" "public_subnets" {
  count = lenght(var.public_subnets_cidrs)
  vpc_id  = aws_vpc.main.id
  cidr_block = element(var.public_subnets_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnets" "private_subnets" {
  count = lenght(var.private_subnets_cidrs)
  vpc_id  = aws_vpc.main.id
  cidr_block = element(var.private_subnets_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "private Subnet ${count.index + 1}"
  }
}

# internet gateway
resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.main.id
 
 tags = {
   Name = "Project VPC IG"
 }
}

# route table
resource "aws_route_table" "second_rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }

    tags = {
        Name = "2nd Route Table"
    }
}

resource "aws_route_table_association" "public_subnet_asso" {
    count = length(var.public_subnets_cidrs)
    subnet_id = elements(aws_subnets.public_subnets[*].id, count.index)
    route_table_id = aws_route_table.second_rt.id
}

# security groups
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 20
    to_port = 20
    protocol = "tcp"
    cidr_blocks = [""] # TODO ad jumpserver ip
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group"
  }
}

# ec2 instances
resource "aws_instance" "public_servers" {
  count = length(var.public_subnets_cidrs)
  ami           = "" # TODO
  instance_type = "t2.micro"
  subnet_id = aws_subnets.public_subnets.id
  vpc_security_group_ids = aws_security_group.sg.id

  tags = {
    Name = "server-${count.index + 1}"
  }
}