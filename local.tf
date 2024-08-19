locals {
  public_subnet_cidr_list = {
    for i in range(0, length(var.azs)) :
    element(var.azs, i) => cidrsubnet(var.vpc_cidr, 4, 0 + i)
  }

  service_subnet_cidr_list = {
    for i in range(0, length(var.azs)) :
    element(var.azs, i) => cidrsubnet(var.vpc_cidr, 4, 4 + i)
  }

  data_subnet_cidr_list = {
    for i in range(0, length(var.azs)) :
    element(var.azs, i) => cidrsubnet(var.vpc_cidr, 4, 8 + i)
  }

  data_subnets_id_list = [
    for subnet in aws_subnet.data : subnet.id
  ]

  service_subnets_id_list = [
    for subnet in aws_subnet.service : subnet.id
  ]

  public_subnets_id_list = [
    for subnet in aws_subnet.public : subnet.id
  ]

  db_config   = jsondecode(data.aws_secretsmanager_secret_version.db_pw.secret_string)
  db_password = local.db_config["password"]
}
