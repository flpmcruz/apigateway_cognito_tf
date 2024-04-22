output "cloudfront_url" {
  value = module.my_website.cloudfront_url
}
output "s3_bucket_name" {
  value = module.my_website.bucket_name
}

output "api_url" {
  value = module.apigateway.api_url
}

output "cognito_user_pool_id" {
  value = module.apigateway.pool_id
}

output "cognito_client_id" {
  value = module.apigateway.client_id
}
