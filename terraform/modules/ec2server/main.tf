resource "aws_security_group" "my-sg" {
  name   = "${var.env_prefix}-nana-sg"
  vpc_id = var.vpc_id
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

resource "aws_key_pair" "my-key" {
  key_name   = var.key_name
  public_key = file("${var.key_path}")
}

data "aws_ami" "latest-ubuntu-image" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = [var.aws_image_name]
  }
}

resource "aws_instance" "my-ec2" {
  ami                         = data.aws_ami.latest-ubuntu-image.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  associate_public_ip_address = true

  user_data = file("setup.sh")

  tags = {
    Name = "${var.env_prefix}-nana-ec2"
  }
}
