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

# ALB :80
#    │
#    │ HTTP request
#    ▼
# Target Group
#    │
#    │ choose healthy target
#    ▼
# Task-IP :3000
resource "aws_lb_target_group" "app" {
    name="${var.project_name}-tg"
    # It's essentially describing the backend destination.
    port=3000
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = data.aws_vpc.default.id
    health_check {
      enabled = true
      path="/health"
      protocol = "HTTP"
      port="traffic-port"

      healthy_threshold = 2
      unhealthy_threshold = 3
      timeout = 5
      interval = 30
      matcher = "200"
    }
    tags = {
        Project     = var.project_name
        Environment = var.environment
        ManagedBy   = "Terraform"
    }


}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.app.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.app.arn
    }
}