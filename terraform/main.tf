# Terraform Configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

# Provider Configuration

provider "aws" {
  region = var.aws_region
}

# S3 Bucket Resource

resource "aws_s3_bucket" "practice_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    MangedBy    = "Terraform"
    CreatedBy   = "Aldwin"
    Purpose     = "Terraform Practice"
  }
}

# S3 Bucket Versioning

resource "aws_s3_bucket_versioning" "practice_bucket_versioning" {
  bucket = aws_s3_bucket.practice_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
