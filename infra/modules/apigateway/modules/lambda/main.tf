## This file creates the Lambda function and the IAM role for the Lambda function
############################################################################################################
## Production Lambda Function
resource "aws_lambda_function" "my_lambda" {
  filename         = "index.zip"
  function_name    = var.name
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  tags = var.tags
}

############################################################################################################
## IAM Role for Lambda
############################################################################################################
resource "aws_iam_role" "lambda_role" {
  name = "${var.name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

############################################################################################################
## Lambda Source Code
############################################################################################################
data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = var.source_code_path
  output_path = "index.zip"
}
