# ============================================
# S3 Outputs
# ============================================

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.app_bucket.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.app_bucket.arn
}

# ============================================
# Security Group Outputs
# ============================================

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.web_sg.name
}

# ============================================
# EC2 Outputs
# ============================================

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

output "instance_state" {
  description = "Current state of the EC2 instance"
  value       = aws_instance.web_server.instance_state
}

output "ssh_command" {
  description = "Copy and run this command to SSH into the server"
  value       = "ssh -i my-first-key.pem ec2-user@${aws_instance.web_server.public_ip}"
}

output "website_url" {
  description = "Open this URL in your browser to see the website"
  value       = "http://${aws_instance.web_server.public_ip}"
}