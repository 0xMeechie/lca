output "load_balancer_dns" {
  description = "DNS of the load balancer serving the container"
  value       = module.ecs.load_balancer_dns
}

output "lb_sg" {
  description = "sg for the load balancer"
  value       = module.ecs.lb_security_group
}

output "ecs_sg" {
  description = "sg id for the ecs"
  value       = module.ecs.ecs_security_group
}

output "rds_sg" {
  description = "sg id for the rds"
  value       = module.ecs.rds_security_group
}

output "vpc_id" {
  description = "id of the vpc"
  value       = module.vpc.vpc_id
}

output "data_subnets" {
  description = "data subnets"
  value       = module.vpc.data_subnets
}

output "public_subnets" {
  description = "public subnets"
  value       = module.vpc.public_subnets
}

output "service_subnets" {
  description = "service subnets"
  value       = module.vpc.service_subnets
}

output "database_name" {
  description = "name of the database"
  value       = module.ecs.database_name
}

output "database_username" {
  description = "username for the database"
  value       = module.ecs.database_username

}

output "database_endpoint" {
  description = "endpoint for the database"
  value       = module.ecs.database_endpoint
}
