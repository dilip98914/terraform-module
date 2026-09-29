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
    BUCKET_NAME = aws_s3_bucket.app.bucket
    }
  }
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

