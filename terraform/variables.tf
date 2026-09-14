variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# us-east-1 (N. Virginia).

variable "project_name" {
  type    = string
  default = "terraform-module"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}