
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

   tags = merge(
    var.tags,               # global tags from Terragrunt
    { Name = "${var.tags["Environment"]}-vpc" }  # resource-specific tag
  )
}


#public Subnet for az zone 1
resource "aws_subnet" "public_sub1" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zones[0]
  cidr_block              = var.subnet_cidr[0]
  map_public_ip_on_launch = true


  tags = merge(
    var.tags,               # global tags from Terragrunt
    { Name = "${var.tags["Environment"]}-pub-subnet1" }  # resource-specific tag
  )
}

#Public Subnet for az zone 2
resource "aws_subnet" "public_sub2" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zones[1]
  cidr_block              = var.subnet_cidr[2]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-pub-subnet2" }  
  )
}

#Private Subnet for az zone 1
resource "aws_subnet" "prisub1" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zones[0]
  cidr_block              = var.subnet_cidr[1]
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-pri-subnet1" }  
  )
}



resource "aws_subnet" "prisub2" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zones[1]
  cidr_block              = var.subnet_cidr[3]
  map_public_ip_on_launch = false

   tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-pri-subnet2" }  
  )
}
