resource "aws_lb" "wordpress" {
  subnets            = var.public_subnets
  internal           = false
  name               = "${var.environment}-${var.ecs_service_name}-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]


}

resource "aws_lb_target_group" "wordpress" {
  name        = "${var.environment}-${var.ecs_service_name}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.wordpress.arn
  port              = var.container_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress.arn
  }
}
