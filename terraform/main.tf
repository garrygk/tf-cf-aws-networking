resource "aws_vpc" "tfvpc" {
  cidr_block       = "10.10.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "tfvpc"
  }
}

resource "aws_internet_gateway" "tfigw" {
  vpc_id = aws_vpc.tfvpc.id

  tags = {
    Name = "tfigw"
  }
}

resource "aws_route_table" "tfpubrt" {
  vpc_id = aws_vpc.tfvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tfigw.id
  }

  tags = {
    Name = "tfpubrt"
  }
}

resource "aws_route_table_association" "tfpubrtAssociation" {
  subnet_id      = aws_subnet.tfpubsubnet.id
  route_table_id = aws_route_table.tfpubrt.id
}

resource "aws_subnet" "tfpubsubnet" {
  vpc_id     = aws_vpc.tfvpc.id
  cidr_block = "10.10.0.0/25"

  tags = {
    Name = "tfpubsubnet"
  }
}

resource "aws_subnet" "tfprivsubnet" {
  vpc_id     = aws_vpc.tfvpc.id
  cidr_block = "10.10.0.128/25"

  tags = {
    Name = "tfprivsubnet"
  }
}


