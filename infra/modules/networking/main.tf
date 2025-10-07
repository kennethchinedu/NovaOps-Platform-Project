
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
resource "aws_subnet" "pri_sub1" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zones[0]
  cidr_block              = var.subnet_cidr[1]
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-pri-subnet1" }  
  )
}


resource "aws_subnet" "pri_sub2" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zones[1]
  cidr_block              = var.subnet_cidr[3]
  map_public_ip_on_launch = false

   tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-pri-subnet2" }  
  )
}



#internet gateway for vpc
resource "aws_internet_gateway" "i-gateway" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-internet-gateway" }  
  )

}

# #Route table for our subnets using the internet gateway
resource "aws_route_table" "public_subnet_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.i-gateway.id
  }

  tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-public-sub-routable" }  
  )

}

resource "aws_route_table_association" "rt_association1" { #associating route table with public subnets
  for_each       = local.public_subnet_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.public_subnet_rt.id

}

#Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {

  tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-nat-eip" }  
  )
}


resource "aws_nat_gateway" "nat_gateway" {

  subnet_id     = local.public_subnet_ids["pubsub1"] # Using the first  public subnet for housing NAT Gateway
  allocation_id = aws_eip.nat_eip.id

   tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-nat-gateway" }  
  )
}

 
 # Route table for private subnet using NAT gateway
resource "aws_route_table" "private_subnet_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = merge(
    var.tags,              
    { Name = "${var.tags["Environment"]}-nat-gateway" }  
  )
}

resource "aws_route_table_association" "rt_association2" {
  for_each       = local.private_subnet_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.private_subnet_rt.id
}
