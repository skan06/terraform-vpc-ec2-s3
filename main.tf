# 👉 Configure the AWS provider
provider "aws" {
  region = var.aws_region
}

##########################
# 🌐 VPC Setup
##########################

# Create a new VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-demo"
  }
}

# Create an Internet Gateway for public internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "igw-demo"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true  # Automatically assign public IP to EC2

  tags = {
    Name = "public-subnet"
  }
}

# Create a public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # All traffic
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Associate the public route table with the public subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

##########################
# 🔐 Security and Access
##########################

# Security group to allow SSH (port 22) from anywhere
resource "aws_security_group" "ssh_sg" {
  name        = "ssh-access"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Upload SSH key (must already exist in the folder)
resource "aws_key_pair" "my_key" {
  key_name   = "my-key-vpc"
  public_key = file("${path.module}/my-key.pub")
}

##########################
# 💻 EC2 Instance in Public Subnet
##########################

resource "aws_instance" "public_ec2" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "public-instance"
  }
}

##########################
# 📦 S3 Bucket
##########################

# Create a private S3 bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true  # allows deleting the bucket even if it contains files

  tags = {
    Name        = "demo-s3"
    Environment = "Dev"
  }
}
