output "client_id" {
  description = "value of the client id"
  value       = aws_cognito_user_pool_client.client.id
}

output "pool_id" {
  description = "value of the pool id"
  value       = aws_cognito_user_pool.pool.id
}

output "arn" {
  description = "value of the arn"
  value       = aws_cognito_user_pool.pool.arn
}