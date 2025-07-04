# AWS region
variable "aws_region" {
  default = "eu-west-1"
}

# VPC CIDR block
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Public subnet CIDR
variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

# Availability zone (change if needed)
variable "availability_zone" {
  default = "eu-west-1a"
}

# Amazon Linux 2 AMI (for Ireland region)
variable "ami_id" {
  default = "ami-0fab1b527ffa9b942"
}

# Unique S3 bucket name
variable "s3_bucket_name" {
  default = "skander-vpc-terraform-s3-demo"
}
