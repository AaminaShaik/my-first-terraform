identifier = "practice-rds-instance"
db_name    = "practice_db"
# storage_type removed: not expected by variables. Use the correct variable name if needed (e.g., allocated_storage or storage_type in module).
engine         = "mysql"
engine_version = "8.0"
instance_class = "db.t3.micro"
allocated_storage = 20
storage_type = "gp2"
username = "adminuser"
password = "Cloud123#67"
backup_retention_period = 7
# db_subnet_group_name = "subnet-group"
# vpc_security_group_ids = [ "value" ]
# Set these after you create a VPC, DB subnet group, and security group.
# db_subnet_group_name   = "my-db-subnet-group"
# vpc_security_group_ids = ["sg-0123456789abcdef0"]

tags = {
  Name        = "practice-rds-instance"
  Environment = "practice"
}

