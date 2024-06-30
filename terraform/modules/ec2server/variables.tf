variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "env_prefix" {
  type        = string
  description = "Environment Prefix"
}

variable "my_ip" {
  type        = string
  description = "My IP"
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

variable "instance_type" {
  type        = string
  description = "Instance Type"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}
