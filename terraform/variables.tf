# ============================================
# AWS Region and Environment
# ============================================

variable "aws_region" {
  description = "AWS region where all resources will be created"
  type        = string
  default     = "ap-southeast-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# ============================================
# S3 Bucket
# ============================================

variable "bucket_name" {
  description = "Name of the S3 bucket - must be globally unique"
  type        = string
  default     = "aldwin-terraform-day9-112704"
}

# ============================================
# EC2 Instance
# ============================================

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for Amazon Linux 2023 in ap-southeast-1"
  type        = string
  default     = "ami-0654aba4091918ebe"
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "dev-web-server"
}