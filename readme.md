# Terraform EC2 Project

This project contains Terraform code to create an EC2 instance within a custom VPC, along with other configurable attributes.

## Prerequisites

- Terraform >= 0.12
- AWS CLI configured with appropriate permissions

## Features

- Custom VPC
- Subnets
- Internet Gateway
- Route Tables
- Security Groups
- EC2 Instance

## Usage

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Ayroid/terraform-ec2-project.git
   cd terraform-ec2-project
   ```

2. **Initialize Terraform:**
   ```sh
   terraform init
   Review and modify variables.tf to set your desired values.
   ```

3. **Apply the Terraform configuration:**

   ```sh
   terraform apply
   ```
Confirm the apply action and wait for the resources to be created.

## Variables
- vpc_cidr_block - CIDR block for the VPC (default: "10.0.0.0/16")
- subnet_cidr_block - CIDR block for the subnet (default: "10.0.1.0/24")
- instance_type - Type of the EC2 instance (default: "t2.micro")
- key_name - Key pair name for SSH access

## Outputs

- instance_id - ID of the created EC2 instance
- instance_public_ip - Public IP address of the created EC2 instance
- vpc_id - ID of the created VPC
- subnet_id - ID of the created subnet

## Cleanup
To destroy the created resources, run:

```sh
terraform destroy
```
