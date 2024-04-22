variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# API Gateway
variable "name" {
  description = "The name for this API Gateway"
  type        = string
}
variable "api_resource_path" {
  description = "The path for the API Gateway resource"
  type        = string
}
variable "stage_name" {
  description = "The name of the stage for this API Gateway"
  type        = string
}

# Lambda
variable "lambda_name" {
  description = "The Lambda function name"
  type        = string
}
variable "source_code_path" {
  description = "The path to the source code of the Lambda function"
  type        = string
}

# Cognito
variable "pool_name" {
  description = "The name of the Cognito User Pool"
  type        = string
}
variable "callback_urls" {
  description = "Cognito callback urls"
  type        = string
  default     = "https://example.com"
}
variable "logout_urls" {
  description = "Cognito logout urls"
  type        = string
  default     = "https://example.com"
}

# Waf ACL
variable "waf_acl_name" {
  description = "The name of the WAF Web ACL"
  type        = string
}
variable "create_waf_acl" {
  description = "Whether to create a WAF Web ACL"
  type        = bool
  default     = false
}
