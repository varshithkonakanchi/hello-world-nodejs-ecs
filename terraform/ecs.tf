resource "aws_ecs_cluster" "main" {
  name = "hello-world-cluster"
}

resource "aws_ecs_task_definition" "hello_world" {
  family                   = "hello-world-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name  = "hello-world"
    image = "YOUR_ECR_REPOSITORY_URL:latest"
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
  }])
}

resource "aws_ecs_service" "main" {
  name            = "hello-world-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.hello_world.arn
  desired_count   = 1

  network_configuration {
    subnets         = ["subnet-0bd61539156ae691c"]
    security_groups = [aws_security_group.default.id]
  }
}
