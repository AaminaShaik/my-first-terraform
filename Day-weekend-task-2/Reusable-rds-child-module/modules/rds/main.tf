resource "aws_db_subnet_group" "sbnt-grp" {
    name = var.db_subnet_group_name
    description ="allow access to the DB subnet group"
    subnet_ids = var.subnet_ids
}
resource "aws_db_parameter_group" "my-db-parameter-group" {
  name   = var.db_parameter_group_name
  family = "mysql8.0"

  description = "My DB Parameter Group"
}
resource "aws_db_instance" "my-db-instance" {
    identifier = var.db_name
    allocated_storage = var.db_allocated_storage
    storage_type = var.db_storage_type
    storage_encrypted = true
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_class
    username = var.db_username
    password = var.db_password
    parameter_group_name = aws_db_parameter_group.my-db-parameter-group.name
    skip_final_snapshot = true
    backup_retention_period = 7
    publicly_accessible = false
    db_subnet_group_name = aws_db_subnet_group.sbnt-grp.name
    vpc_security_group_ids = [var.sg_id]
    apply_immediately       = true
    depends_on = [ aws_db_subnet_group.sbnt-grp ]
}

resource "aws_db_instance" "replica" {
    identifier = var.db_name_replica
    replicate_source_db     = aws_db_instance.my-db-instance.arn
    # allocated_storage = var.db_allocated_storage
    storage_type = var.db_storage_type
    storage_encrypted = true
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_class
    # username = var.db_username
    # password = var.db_password
    parameter_group_name = var.db_parameter_group_name
    skip_final_snapshot = true
    backup_retention_period = 7
    publicly_accessible = false
    db_subnet_group_name = aws_db_subnet_group.sbnt-grp.name
    vpc_security_group_ids = [var.sg_id]
    apply_immediately       = true
    tags = {
        Name = "${var.db_name}-replica"
    }
    depends_on = [ aws_db_instance.my-db-instance ]
}