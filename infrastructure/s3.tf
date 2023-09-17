# S3 Bucket
resource "aws_s3_bucket" "website" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_policy" "read_only" {
  bucket = aws_s3_bucket.website.bucket
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowCloudFrontServicePrincipalReadOnly",
        "Effect": "Allow",
        "Principal": {
          "Service": "cloudfront.amazonaws.com"
        },
        "Action": "s3:GetObject",
        "Resource": "${aws_s3_bucket.website.arn}/*",
        "Condition": {
          "StringEquals": {
            "aws:SourceArn": "${aws_cloudfront_distribution.website_distribution.arn}"
          }
        }
      }
    ]
  }
EOF
}