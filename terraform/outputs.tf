# Output Values

output "bucket_name" {
  description = "The name of the S3 bucket."
  value       = aws_s3_bucket.practice_bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket."
  value       = aws_s3_bucket.practice_bucket.arn
}

output "bucket_region" {
  description = "The AWS region where the S3 bucket is created."
  value       = aws_s3_bucket.practice_bucket.region
}

output "versioning_status" {
  description = "Whether versioning is enabled on the bucket."
  value       = aws_s3_bucket_versioning.practice_bucket_versioning.versioning_configuration[0].status
}