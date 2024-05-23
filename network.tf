# VPC
resource "aws_vpc" "eb_vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "eb-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "eb_public_subnet1" {
  vpc_id     = aws_vpc.eb_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 0) 
  // 8 > It will add +8 mask to current cidr_block // 0 > It select first subnet from the range
  map_public_ip_on_launch = true
  availability_zone = var.avail_zones[0]  //0> Select first availability zone from list

  tags = {
    Name = "eb-public-subnet1"
    Type = "Public"
  }
}

# Private Subnet
resource "aws_subnet" "eb_private_subnet1" {
  vpc_id     = aws_vpc.eb_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 4) 
  // 8 > It will add +8 mask to current cidr_block // 4 > It select fifth subnet from the range
  map_public_ip_on_launch = false
  availability_zone = var.avail_zones[0]  //0> Select first availability zone from list

  tags = {
    Name = "eb-private-subnet1"
    Type = "Private"
  }
}


# Add internet gateway
resource "aws_internet_gateway" "eb_igw" {
    vpc_id = "${aws_vpc.eb-vpc.id}"
    tags = {
        Name = "eb-igw"
    }
}

# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "nat_gateway" {
    vpc = true
}
resource "aws_nat_gateway" "eb_nat_gw" {
    allocation_id = aws_eip.nat_gateway.id
    subnet_id     = "${aws_subnet.eb_public_subnet1.id}"

    tags = {
    Name = "eb-nat-gw"
    
    depends_on = [aws_internet_gateway.eb_igw]
    }

# Public Route Table
resource "aws_route_table" "eb_pub_rt1" {
    vpc_id = "${aws_vpc.eb-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = "${aws_internet_gateway.eb_igw.id}" 
    }
    
    tags = {
        Name = "eb-pub-rt1"
    }
}

# Public Route Table Association
resource "aws_route_table_association" "eb_pub_rt1_sub1"{
    subnet_id = "${aws_subnet.eb_public_subnet1.id}"
    route_table_id = "${aws_route_table.eb_pub_rt1.id}"
}

# Private Route Table
resource "aws_route_table" "eb_priv_rt1" {
    vpc_id = "${aws_vpc.eb_vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.eb_nat_gw.id}" 
    }
    
    tags = {
        Name = "eb-priv-rt1"
    }
}

# Private Route Table Association
resource "aws_route_table_association" "eb_priv_rt1_sub1"{
    subnet_id = "${aws_subnet.eb-private-subnet1.id}"
    route_table_id = "${aws_route_table.eb_priv_rt1.id}"
}
