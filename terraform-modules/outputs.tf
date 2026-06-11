# VPC Outputs

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnets
}

output "nat_gateway_ip" {
  description = "Public IP of the NAT Gateway"
  value       = module.vpc.nat_public_ips
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

# EC2 Outputs

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_private_ip" {
  description = "Private IP of the EC2 instance inside the VPC"
  value       = aws_instance.web_server.private_ip
}

output "website_url" {
  description = "URL to access the web server"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "ssh_command" {
  description = "Command to SSH into the web server"
  value       = "ssh -i my-first-key.pem ec2-user@${aws_instance.web_server.public_ip}"
}

# Security Group Outputs

output "security_group_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web_sg.id
}

# Summary Output

output "infrastructure_summary" {
  description = "Summary of all created infrastructure"
  value = {
    vpc_id             = module.vpc.vpc_id
    public_subnets     = module.vpc.public_subnets
    private_subnets    = module.vpc.private_subnets
    web_server_ip      = aws_instance.web_server.public_ip
    web_server_private = aws_instance.web_server.private_ip
  }
}