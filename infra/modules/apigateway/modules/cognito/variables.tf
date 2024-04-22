variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# Cognito variables
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
