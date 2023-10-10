variable "region" {
  description = "Value of the region"
  type        = string
  default     = "eu-central-1"
}

variable "profile" {
  description = "Value of the profile"
  type        = string
  default     = "dev_profile"
}

variable "app-tag" {
  description = "Value of the default tag"
  type        = string
  default     = "lambda-with-go-tutorial"
}
