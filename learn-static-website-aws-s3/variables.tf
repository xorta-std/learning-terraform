variable "region" {
  description = "Value of the region"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "Value of the bucket name for my static website"
  type        = string
  default     = "my-static-website-a3893"
}

variable "deploy_profile" {
  description = "Value of the profile"
  type        = string
  default     = "dev_profile"
}
