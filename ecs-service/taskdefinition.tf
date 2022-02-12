resource "aws_ecs_task_definition" "service" {
  family = "factorial"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu    = 256
  memory = 512
  execution_role_arn = "arn:aws:iam::364485175950:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name      = "factorial"
      image     = "364485175950.dkr.ecr.ap-south-1.amazonaws.com/factorial:latest"
      
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    }
  ])

 
}