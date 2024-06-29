resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-${var.vpc_name}"
  }
}

resource "aws_subnet" "my-subnet-1" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.env_prefix}-${var.subnet_name}"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "${var.env_prefix}-nana-igw"
  }
}

resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "${var.env_prefix}-nana-route-table"
  }
}

resource "aws_route_table_association" "my-route-table-association" {
  subnet_id      = aws_subnet.my-subnet-1.id
  route_table_id = aws_route_table.my-route-table.id
}

# This is an example of how to create a default route table and associate it with a VPC

/* 
   resource "aws_default_route_table" "my-default-route-table" {
   default_route_table_id = aws_vpc.my-vpc.default_route_table_id

   route = {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.my-igw.id
   }

   tags = {
     Name = "${var.env_prefix}-nana-default-route-table"
   }
   } 
 
 */
