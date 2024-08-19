data "aws_secretsmanager_secret" "db_pw" {
  arn = aws_db_instance.main.master_user_secret[0].secret_arn

}

data "aws_secretsmanager_secret_version" "db_pw" {
  secret_id = data.aws_secretsmanager_secret.db_pw.id
}
