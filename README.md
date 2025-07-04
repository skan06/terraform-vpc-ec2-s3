# terraform-vpc-ec2-s3

This project demonstrates how to provision AWS infrastructure using Terraform. It includes a custom VPC with public and private subnets, an EC2 instance in the public subnet, and an S3 bucket in the private subnet. The infrastructure follows AWS best practices for security and modular design.

## ✅ What This Project Does

- 🏗️ Creates a custom VPC
- 🌐 Adds a public and private subnet in two availability zones
- 📡 Creates an Internet Gateway and associates a route table to the public subnet
- 🛡️ Configures security groups to allow SSH access
- 💻 Launches an EC2 instance (Amazon Linux 2023) in the public subnet
- 📦 Deploys a private S3 bucket
- 🔑 Associates an IAM Role with the EC2 instance to allow S3 access
- 📤 Uploads files from the EC2 instance to the S3 bucket (via CLI)
