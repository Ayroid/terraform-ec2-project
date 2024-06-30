output "aws_ami_id" {
  value = module.ec2server-module.aws_ami_id
}

output "public_ip" {
  value = module.ec2server-module.public_ip
}
