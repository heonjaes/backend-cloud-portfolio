terraform {
  backend "s3" {
    bucket = "heonjae-resume-tfstate"
    region = "ap-southeast-2"                   
    key    = "terraform.tfstate"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

# S3 

module "s3_module" {
  source = "./s3"
}


# Cloudfront
resource "aws_cloudfront_origin_access_control" "resume" {
  name                              = "Heonjae S3 OAC"
  description                       = "Heonjae resume S3 OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "website_distribution" {
  comment = var.cloudfront_distribution_name

  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id                = "S3-${aws_s3_bucket.website.id}"
    origin_access_control_id = aws_cloudfront_origin_access_control.resume.id
  }

  aliases = ["resume.heonjaeshin.com"]

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.website.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.cloudfront_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

# DynamoDB
resource "aws_dynamodb_table" "table" {
  name         = "resume-count-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"

  attribute {
    name = "ID"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "test" {
  table_name = aws_dynamodb_table.table.name
  hash_key   = aws_dynamodb_table.table.hash_key

  lifecycle {
    ignore_changes = all
  }

  item = <<ITEM
{
  "ID": {"S": "0"},
  "visit_count": {"N": "0"}
}
ITEM
}

# Route53
resource "aws_route53_zone" "resume_website" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "resume_website" {
  zone_id = aws_route53_zone.resume_website.zone_id
  name    = "resume.heonjaeshin.com"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.website_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.website_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}


# Lambda
resource "aws_lambda_function" "lambda_py" {
  filename         = "lambda/lambda4dynamodb.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.assume_policy.arn
  runtime          = "python3.9"
  handler          = "lambda4dynamodb.lambda_handler"
  source_code_hash = filebase64sha256("lambda/lambda4dynamodb.zip")
}

resource "aws_iam_role" "assume_policy" {
  name = "visit_count_access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "iam_policy_for_resume_project" {
  name        = "access_visit_count_database"
  path        = "/"
  description = "AWS IAM Policy for managing the resume project role"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:*:*:*",
        "Effect" : "Allow"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:UpdateItem",
          "dynamodb:GetItem",
          "dynamodb:PutItem"
        ],
        "Resource" : "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.table.name}"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_policy_to_iam_role" {
  role       = aws_iam_role.assume_policy.name
  policy_arn = aws_iam_policy.iam_policy_for_resume_project.arn
}

resource "aws_lambda_function_url" "counter_url" {
  function_name      = aws_lambda_function.lambda_py.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}


# API Gateway
resource "aws_apigatewayv2_api" "api" {
  name          = "my-api"
  protocol_type = "HTTP"
  target        = aws_lambda_function.lambda_py.arn
  cors_configuration {
    allow_origins = ["*"]
  }
}

# Integration
resource "aws_apigatewayv2_integration" "integration" {
  api_id             = aws_apigatewayv2_api.api.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_py.invoke_arn
}

# Permission
resource "aws_lambda_permission" "apigw" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_py.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
