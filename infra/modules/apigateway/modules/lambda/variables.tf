variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "source_code_path" {
  description = "The path to the source code of the Lambda function"
  type        = string
}

variable "name" {
  description = "The name of the Lambda function"
  type        = string
}
