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

resource "aws_security_group" "my-sg" {
  name   = "${var.env_prefix}-nana-sg"
  vpc_id = aws_vpc.my-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-nana-sg"
  }
}

# This is an example of how to create a default security group with ingress and egress rules

/* 
   resource "aws_default_security_group" "my-default-sg" {
   vpc_id = aws_vpc.my-vpc.id

   ingress {
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = [var.my_ip]
   }

   ingress {
     from_port   = 8080
     to_port     = 8080
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.env_prefix}-nana-sg"
    }

    }

*/

data "aws_ami" "latest-ubuntu-image" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
  }
}

output "aws_ami_id" {
  value = data.aws_ami.latest-ubuntu-image.id
}

resource "aws_key_pair" "my-key" {
  key_name   = var.key_name
  public_key = file("${var.key_path}")
}

resource "aws_instance" "my-ec2" {
  ami                         = data.aws_ami.latest-ubuntu-image.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.my-subnet-1.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  associate_public_ip_address = true

  user_data = file("setup.sh")

  tags = {
    Name = "${var.env_prefix}-nana-ec2"
  }
}

output "public_ip" {
  value = aws_instance.my-ec2.public_ip
}
