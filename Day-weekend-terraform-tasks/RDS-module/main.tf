module "rds" {
  source = "./modules/rds"

  identifier              = var.identifier
  db_name                 = var.db_name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  username                = var.username
  password                = var.password
#   db_subnet_group_name    = var.db_subnet_group_name
#   vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible     = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  tags                    = var.tags
}




























# resource "aws_db_instance" "this" {
#   identifier              = var.identifier != "" ? var.identifier : var.db_name
#   db_name                 = var.db_name
#   allocated_storage       = var.allocated_storage
#   engine                  = var.engine
#   engine_version          = var.engine_version
#   instance_class          = var.instance_class
#   username                = var.username
#   password                = var.password
#   skip_final_snapshot     = var.skip_final_snapshot
#   publicly_accessible     = var.publicly_accessible
#   backup_retention_period = var.backup_retention_period
#   db_subnet_group_name    = var.db_subnet_group_name
#   vpc_security_group_ids = var.vpc_security_group_ids

#   tags = merge(
#     {
#       Name = var.identifier != "" ? var.identifier : var.db_name
#     },
#     var.tags
#   )
# }