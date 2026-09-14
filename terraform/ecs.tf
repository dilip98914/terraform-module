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

resource "aws_ecs_task_definition" "app" {
  family             = var.project_name
  network_mode       = "awsvpc"
  cpu                = "256"
  memory             = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  container_definitions =jsonencode([
    {
      name      = var.project_name
      image     = "${aws_ecr_repository.app.repository_url}:${var.image_tag}"
      essential = true

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          name  = "PORT"
          value = "3000"
        }
      ]

      healthCheck = {
        command = [
          "CMD-SHELL",
          "wget -qO- http://localhost:3000/health || exit 1"
        ]

        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 10
      }
      logConfiguration = {
        logDriver = "awslogs"

        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.app.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "app"
        }
      }

    }
  ])
}