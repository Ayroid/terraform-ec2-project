module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  name           = var.vpc_name
  cidr           = var.vpc_cidr_block
  azs            = [var.availability_zone]
  public_subnets = [var.subnet_cidr_block]
  public_subnet_tags = {
    Name = "${var.env_prefix}-${var.subnet_name}"
  }
  tags = {
    Name = "${var.env_prefix}-${var.vpc_name}"
  }
}

module "ec2server-module" {
  source         = "./modules/ec2server"
  env_prefix     = var.env_prefix
  vpc_id         = module.vpc.vpc_id
  my_ip          = var.my_ip
  key_name       = var.key_name
  key_path       = var.key_path
  aws_image_name = var.aws_image_name
  instance_type  = var.instance_type
  subnet_id      = module.vpc.public_subnets[0]
}

