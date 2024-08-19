resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-${var.ecs_cluster_name}"

  configuration {

  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }


}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 100
    base              = 1
  }

}

resource "aws_ecs_task_definition" "wordpress" {
  family                   = "${var.environment}-${var.ecs_service_name}-td"
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  container_definitions = templatefile("${path.module}/files/website-td.json", {
    DB_HOST = aws_db_instance.main.endpoint
    DB_USER = var.db_username
    DB_PW   = local.db_password
  })

}

resource "aws_ecs_service" "wordpress" {
  name                 = "${var.ecs_service_name}-service"
  cluster              = aws_ecs_cluster.main.id
  task_definition      = aws_ecs_task_definition.wordpress.arn
  desired_count        = 1
  force_new_deployment = true


  network_configuration {
    subnets         = local.service_subnets_id_list
    security_groups = [aws_security_group.ecs.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.wordpress.arn
    container_name   = "wordpress"
    container_port   = 80
  }
}
