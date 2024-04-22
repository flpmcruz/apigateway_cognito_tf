variable "bucket_name" {
  description = "Name of the S3 bucket to store the Terraform state file"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table to store the Terraform state lock"
  type        = string
}
