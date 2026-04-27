resource "aws_ecs_cluster" "main" {
  name = "ecspf-cluster"
}

resource "aws_ecs_task_definition" "main" {
  family = "ecspf"
  cpu = "256"
  memory = "512"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([{
    name = "app"
    image = var.ecr_repository_url
    portMappings = [{
        containerPort = 8000
        protocol = "tcp"
    }]
    logConfiguration = {
        logDriver = "awslogs"
        options = {
            awslogs-group = "/ecs/ecspf"
            awslogs-region = "ap-northeast-1"
            awslogs-stream-prefix = "ecs"
        }
    }
  }])
}
