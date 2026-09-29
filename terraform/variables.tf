variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "terraform-module"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "enable_ecs" {
  type        = bool
  default     = false
  description = "Whether to provision ECS"
}
variable "enable_lambda" {
  type    = bool
  default = true
}
