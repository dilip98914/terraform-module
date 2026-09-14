resource "aws_lb" "app" {
  name="${var.project_name}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.alb.id
  ]
  subnets = data.aws_subnets.default.ids
  tags={
    Project=var.project_name
    Environment=var.environment
    ManagedBy="Terraform"
  }
}