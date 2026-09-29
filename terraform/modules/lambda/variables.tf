variable "project_name" {
  type    = string
  default = "terraform-module"
}
variable "lambda_zip" {
  type    = string
  default = "../lambda.zip"
}
variable "environment" {
  type    = string
  default = "dev"
}