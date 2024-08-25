output "public_subnets" {
  description = "The IDs of the public/ingress subnets keyed by the hosted availability zone."
  value = {
    for subnet in aws_subnet.public : subnet.id => subnet.cidr_block
  }
}

output "data_subnets" {
  description = "The IDs of the management subnets keyed by the hosted availability zone."
  value = {
    for subnet in aws_subnet.data : subnet.id => subnet.cidr_block
  }
}

output "service_subnets" {
  description = "The IDs of the web subnets keyed by the hosted availability zone."
  value = {
    for subnet in aws_subnet.service : subnet.id => subnet.cidr_block
  }
}

output "vpc_id" {
  description = "VPC id"
  value       = aws_vpc.main.id

}

output "data_subnet_ids" {
  description = "A list of subnet IDs."
  value       = [for subnet in aws_subnet.data : subnet.id]
}

output "public_subnet_ids" {
  description = "A list of subnet IDs."
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "service_subnet_ids" {
  description = "A list of subnet IDs."
  value       = [for subnet in aws_subnet.service : subnet.id]
}
