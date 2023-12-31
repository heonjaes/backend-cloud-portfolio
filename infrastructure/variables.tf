variable "aws_access_key" {
  description = "AWS access key for authentication."
  type        = string
}

variable "tf_state_bucket" {
  description = "Name of the S3 bucket for Terraform state."
  type        = string
  default = "heonjae-resume-tfstate"
}

variable "aws_secret_key" {
  description = "AWS secret key for authentication."
  type        = string
}

variable "aws_region" {
  description = "AWS region for resources."
  type        = string
  default     = "ap-southeast-2"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for the website."
  type        = string
  default     = "heonjae-resume-website"
}

variable "cloudfront_certificate_arn" {
  description = "ACM certificate ARN for CloudFront distribution."
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the AWS Lambda function."
  type        = string
  default     = "resume-visit-counter"
}

variable "route53_zone_name" {
  description = "Name of the Route 53 DNS zone."
  type        = string
  default     = "heonjaeshin.com"
}

variable "cloudfront_distribution_name" {
  description = "Name for the CloudFront distribution."
  type        = string
  default     = "Heonjae's resume portfolio website distribution"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for visit count."
  type        = string
  default     = "resume-count-table" # Default value if needed
}