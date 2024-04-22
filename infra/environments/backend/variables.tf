variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-1"
}
variable "prod_backend_bucket_name" {
  description = "Name of the S3 bucket to store the terraform state file"
  type        = string
  validation {
    condition     = length(var.prod_backend_bucket_name) > 3
    error_message = "Bucket name should be more than 3 characters"
  }
}
variable "prod_backend_table_name" {
  description = "Name of the DynamoDB table to lock the terraform state file"
  type        = string
}
variable "dev_backend_bucket_name" {
  description = "Name of the S3 bucket to store the terraform state file"
  type        = string
  validation {
    condition     = length(var.dev_backend_bucket_name) > 3
    error_message = "Bucket name should be more than 3 characters"
  }
}
variable "dev_backend_table_name" {
  description = "Name of the DynamoDB table to lock the terraform state file"
  type        = string
}
