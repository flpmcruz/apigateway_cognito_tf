variable "environment" {
  description = "Environment in which the resources are to be created"
  type        = string
  default     = "prod"
}

variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}

variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "api_resource_path" {
  description = "Resource path for the API Gateway"
  type        = string
}

variable "pool_name" {
  description = "Name of the Cognito User Pool"
  type        = string
}

variable "waf_acl_name" {
  description = "Name of the WAF ACL"
  type        = string
}

variable "lambda_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "price_class" {
  description = "Price class for CloudFront distribution"
  type        = string
}

variable "distribution_name" {
  description = "Name of the CloudFront distribution"
  type        = string
}