resource "aws_lb" "wordpress" {
  subnets            = local.public_subnets_id_list
  internal           = false
  name               = "${var.environment}-${var.ecs_service_name}-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]


}

resource "aws_lb_target_group" "wordpress" {
  name        = "${var.environment}-${var.ecs_service_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.wordpress.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress.arn
  }
}
