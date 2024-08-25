locals {
  db_config   = jsondecode(data.aws_secretsmanager_secret_version.db_pw.secret_string)
  db_password = local.db_config["password"]
}
