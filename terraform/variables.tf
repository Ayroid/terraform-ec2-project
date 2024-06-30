variable "aws_region" {
  type        = string
  description = "AWS Default Region"
}

variable "aws_access_key" {
  type        = string
  description = "AWS Admin Access Key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Admin Secret Key"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block for the subnet"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone"
}

variable "env_prefix" {
  type        = string
  description = "Environment Prefix"
}

variable "my_ip" {
  type        = string
  description = "My IP"
}

variable "instance_type" {
  type        = string
  description = "Instance Type"
}

variable "key_name" {
  type        = string
  description = "Key Pair Name"
}

variable "key_path" {
  type        = string
  description = "Key Pair Path"
}

variable "aws_image_name" {
  type        = string
  description = "AMI ID"
}
