resource "aws_s3_bucket" "app" {
  # bucket = "${var.project_name}-${var.environment}-bucket"
  bucket_prefix = "${var.project_name}-${var.environment}-"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}