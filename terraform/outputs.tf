output "aws_ami_id" {
  value = data.aws_ami.latest-ubuntu-image.id
}

output "public_ip" {
  value = aws_instance.my-ec2.public_ip
}
