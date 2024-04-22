

# Output values for the module
output "client_id" {
  description = "value of the client id"
  value       = module.cognito.client_id
}

output "pool_id" {
  description = "value of the pool id"
  value       = module.cognito.pool_id
}

output "api_url" {
  description = "value of the api url"
  value       = "${aws_api_gateway_stage.my_stage.invoke_url}/${var.api_resource_path}"
}
