resource "aws_db_subnet_group" "main" {

  subnet_ids = var.rds_subnets


}


resource "aws_db_instance" "main" {
  instance_class              = var.db_instance_class
  max_allocated_storage       = var.max_storage
  allocated_storage           = var.max_storage / 2
  db_name                     = "${var.environment}${var.db_name}"
  db_subnet_group_name        = aws_db_subnet_group.main.name
  engine                      = var.db_engine
  engine_version              = var.db_engine_version
  manage_master_user_password = true
  multi_az                    = true
  identifier                  = "${var.environment}-${var.db_name}"
  // skipping final snapshot to speed up destroy
  skip_final_snapshot    = true
  username               = var.db_username
  vpc_security_group_ids = [aws_security_group.rds.id]

}
