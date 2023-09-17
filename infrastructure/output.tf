# S3 bucket
output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.website.arn
}

# CloudFront distribution
output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website_distribution.domain_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website_distribution.id
}

# DynamoDB table
output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.table.name
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.table.arn
}

# Route53 zone and record
output "route53_zone_name" {
  description = "The name of the Route53 DNS zone"
  value       = aws_route53_zone.resume_website.name
}

output "route53_record_name" {
  description = "The name of the Route53 DNS record"
  value       = aws_route53_record.resume_website.name
}

output "route53_record_type" {
  description = "The type of the Route53 DNS record"
  value       = aws_route53_record.resume_website.type
}

# Lambda function
output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.lambda_py.function_name
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.lambda_py.arn
}

# API Gateway
output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = aws_apigatewayv2_api.api.id
}
