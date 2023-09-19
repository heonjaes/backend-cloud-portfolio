# Lambda
resource "aws_lambda_function" "lambda_py" {
  filename         = "lambda/get_count.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.assume_policy.arn
  runtime          = "python3.9"
  handler          = "get_count.lambda_handler"
  source_code_hash = filebase64sha256("lambda/get_count.zip")
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