resource "aws_lambda_function" "app" {
  function_name    = var.project_name
  role             = aws_iam_role.lambda_execution.arn
  runtime          = "nodejs22.x"
  handler          = "index.handler"
  filename         = var.lambda_zip
  source_code_hash = filebase64sha256(var.lambda_zip)
  timeout          = 10
  memory_size      = 256
  environment {
    variables = {
      NODE_ENV = "production"
    }
  }
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_role" "lambda_execution" {
  name = "${var.project_name}-lambda-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role = aws_iam_role.lambda_execution.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}