resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-${var.vpc_name}"
  }
}

module "subnet-module" {
  source            = "./modules/subnet"
  vpc_id            = aws_vpc.my-vpc.id
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  env_prefix        = var.env_prefix
  subnet_name       = var.subnet_name
}

module "ec2server-module" {
  source         = "./modules/ec2server"
  env_prefix     = var.env_prefix
  vpc_id         = aws_vpc.my-vpc.id
  my_ip          = var.my_ip
  key_name       = var.key_name
  key_path       = var.key_path
  aws_image_name = var.aws_image_name
  instance_type  = var.instance_type
  subnet_id      = module.subnet-module.subnet_id
}

