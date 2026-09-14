resource "aws_ecs_cluster" "app" {
  name = "${var.project_name}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Project     = var.project_name
    Environment = var.environment
  ManagedBy = "Terraform" }
}