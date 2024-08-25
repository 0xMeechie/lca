output "load_balancer_dns" {
  description = "dns of the load balancer"
  value       = aws_lb.wordpress.dns_name
}

output "rds_security_group" {

  description = "security group id for the rds database"
  value       = aws_security_group.rds.id
}

output "ecs_security_group" {

  description = "security group id for the ecs cluster"
  value       = aws_security_group.ecs.id
}

output "lb_security_group" {

  description = "security group id for the load balancer"
  value       = aws_security_group.lb.id
}

output "database_name" {
  description = "name of the database"
  value       = aws_db_instance.main.db_name

}

output "database_username" {
  description = "username of the database"
  value       = aws_db_instance.main.username

}

output "database_endpoint" {
  description = "database endpoint"
  value       = aws_db_instance.main.endpoint

}
