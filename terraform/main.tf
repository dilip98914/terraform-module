module "ecs" {
  count  = var.enable_ecs ? 1 : 0
  source = "./modules/ecs"
}

module "lambda" {
  count        = var.enable_lambda ? 1 : 0
  source       = "./modules/lambda"
  project_name = var.project_name
  environment  = var.environment
  lambda_zip   = "index.zip"
}

module "sqs" {
  count                      = var.enable_sqs ? 1 : 0
  source                     = "./modules/sqs"
  name                       = "${var.project_name}-${var.environment}-messages"
  max_receive_count          = 3
  visibility_timeout_seconds = 60
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}