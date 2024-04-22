output "name" {
  value = aws_lambda_function.my_lambda.function_name
}

output "invoke_arn" {
  value = aws_lambda_function.my_lambda.invoke_arn
}