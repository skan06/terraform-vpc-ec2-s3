# Show the public IP of the EC2 instance after deployment
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.public_ec2.public_ip
}

# Show the S3 bucket name
output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.demo_bucket.id
}
