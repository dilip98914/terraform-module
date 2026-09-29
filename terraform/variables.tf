variable "enable_ecs" {
  type=bool
  default = false
  description = "Whether to provision ECS"
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "enable_lambda" {
  type    = bool
  default = false
}