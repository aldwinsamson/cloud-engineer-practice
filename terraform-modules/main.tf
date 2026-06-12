# VPC Module
# This module creates the entire VPC includeing:
# - VPC with CIDR you specify
# - Public and private subnets in the availability zones you specify
# - Internet Gateway for public subnets
# - NAT Gateway so private subnets can reach the internet
# - Route tables for public and private subnets

# Data Source - Get Available AZs

data "aws_availability_zones" "available" {
  state = "available"
}

# VPC Module

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Type = "public"
  }

  private_subnet_tags = {
    Type = "private"
  }
}

# Security Group for Web Server

resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-web-sg"
  description = "Security group for web server"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-web-sg"
  }
}

# EC2 Instance in Public Subnet

resource "aws_instance" "web_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = "my-first-key"
  iam_instance_profile         = aws_iam_instance_profile.ec2_cloudwatch_profile.name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx amazon-cloudwatch-agent
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Hello from Terraform Day 11!</h1>" > /usr/share/nginx/html/index.html
              echo "<p>VPC: ${module.vpc.vpc_id}</p>" >> /usr/share/nginx/html/index.html
              echo "<p>Server: $(hostname)</p>" >> /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-web-server"
  }
}

# IAM Role for CloudWatch Agent

resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "${var.project_name}-ec2-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-ec2-cloudwatch-role"
  }
}

# Attach the AWS managed CloudWatch Agent policy
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Instance profile - this is what actually attaches to the EC2
resource "aws_iam_instance_profile" "ec2_cloudwatch_profile" {
  name = "${var.project_name}-ec2-cloudwatch-profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}