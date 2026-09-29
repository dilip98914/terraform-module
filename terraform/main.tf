module "ecs" {
  count = var.enable_ecs?1:0
  source="./modules/ecs"  
}

module "lambda"{
    count = var.enable_lambda?1:0
    source = "./modules/lambda"
 project_name = var.project_name
  environment  = var.environment
  lambda_zip   = "index.zip"
  }