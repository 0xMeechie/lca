resource "aws_security_group" "lb" {
  name        = "${var.environment}-${var.ecs_service_name}-lb"
  description = "Allow connection to the LB from the world"
  vpc_id      = aws_vpc.main.id

}


resource "aws_vpc_security_group_ingress_rule" "allow_80_traffic" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_out_lb" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


resource "aws_security_group" "ecs" {
  name        = "${var.environment}-${var.ecs_service_name}-ecs"
  vpc_id      = aws_vpc.main.id
  description = "Allow connection from the lb to the cluster"

}


resource "aws_vpc_security_group_ingress_rule" "allow_all_ecs" {
  security_group_id            = aws_security_group.ecs.id
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.lb.id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_out_ecs" {
  security_group_id = aws_security_group.ecs.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "rds" {
  name        = "${var.environment}-${var.ecs_service_name}-rds"
  vpc_id      = aws_vpc.main.id
  description = "Allow connection to the database"

}


resource "aws_vpc_security_group_ingress_rule" "allow_all_rds" {
  security_group_id            = aws_security_group.rds.id
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.ecs.id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_out_rds" {
  security_group_id = aws_security_group.rds.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

