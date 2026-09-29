output "function_name" {
  value = aws_lambda_function.app.function_name
}

output "function_arn" {
  value = aws_lambda_function.app.arn
}

output "execution_role_arn" {
  value = aws_iam_role.lambda_execution.arn
}