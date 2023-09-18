#creating vpc
resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "{var.project_name}-eks"
    Env  = var.env
    type = var.type
  }
}

#creating IGW
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "{var.project_name}-igw"
    Env  = var.env
    type = var.type
  }
}

#Using data source to get all Avalablility Zones
data "aws_availability_zones" "azs" {}

# Creating Public Subnet AZ1
resource "aws_subnet" "pub-az1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.azs.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "pub-sub-az1"
    Env  = var.env
    Type = var.type
  }
}

# Creating Public Subnet AZ2
resource "aws_subnet" "pub-az2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.azs.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "pub-sub-az2"
    Env  = var.env
    Type = var.type
  }
}

# Creating Route Table and add Public Route
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "Public Route Table"
    Env  = var.env
    Type = var.type
  }
}

# Associating Public Subnet in AZ1 to route table
resource "aws_route_table_association" "pub-rt-association-az1" {
  subnet_id      = aws_subnet.pub-az1.id
  route_table_id = aws_route_table.pub-rt.id
}

# Associating Public Subnet in AZ2 to route table
resource "aws_route_table_association" "pub-rt-association-az2" {
  subnet_id      = aws_subnet.pub-az2.id
  route_table_id = aws_route_table.pub-rt.id
}