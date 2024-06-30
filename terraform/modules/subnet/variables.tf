variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone"
}

variable "env_prefix" {
  type        = string
  description = "Environment Prefix"
}
