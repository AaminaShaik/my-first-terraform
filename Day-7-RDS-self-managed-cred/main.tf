resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = var.tags_vpc
    }
}
resource "aws_subnet" "my_subnet_1a" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidr_1a
    availability_zone = var.availability_zone_1a
    tags = {
      Name = var.tags_subnet_1a
    }
}
resource "aws_subnet" "my_subnet_1b" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidr_1b
    availability_zone = var.availability_zone_1b
    tags = {
      Name = var.tags_subnet_1b
    }
}
resource "aws_security_group" "my_security_group" {
    name = var.security_group_name
    description = var.security_group_description
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = var.s3_bucket_name
  # 'acl' is deprecated; leaving default ownership and access controls.
}
resource "aws_db_subnet_group" "my_db_subnet_group" {
    name = var.db_subnet_group_name
    description = var.db_subnet_group_description
    #vpc_id = aws_vpc.my_vpc.id
    subnet_ids = [aws_subnet.my_subnet_1a.id, aws_subnet.my_subnet_1b.id]
}
resource "aws_db_instance" "my_db_instance" {
    allocated_storage = var.db_allocated_storage
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_class
    # db_name = var.db_name
    identifier = var.db_name
    username = var.db_username
    password = var.db_password
    parameter_group_name = var.db_parameter_group_name
    skip_final_snapshot = true
    db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    backup_retention_period = 7
    apply_immediately       = true
}
resource "aws_db_instance" "my_db_instance_replica" {
    # Use the source DB's ARN for replication. Remove unexpected attribute
    replicate_source_db = aws_db_instance.my_db_instance.arn
    instance_class = var.db_instance_class
    db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    identifier = var.db_replica
}
resource "aws_elasticache_subnet_group" "my_elasticache_subnet_group" {
  name       = "my-elasticache-subnet-group"
  subnet_ids = [aws_subnet.my_subnet_1a.id, aws_subnet.my_subnet_1b.id]
}
resource "aws_elasticache_cluster" "my_elasticache_cluster" {
  cluster_id           = var.redis_cluster_id
  engine               = var.redis_engine
  engine_version       = var.redis_engine_version
  node_type            = var.redis_node_type
  num_cache_nodes      = var.redis_num_cache_nodes
  parameter_group_name = var.redis_parameter_group_name
  subnet_group_name    = aws_elasticache_subnet_group.my_elasticache_subnet_group.name
  security_group_ids   = [aws_security_group.my_security_group.id]
  # 'cluster_id' is used for ElastiCache cluster identification; remove duplicate/unsupported 'identifier'
}



