resource "aws_elasticache_subnet_group" "redis" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
}
resource "aws_elasticache_parameter_group" "redis" {
  name        = var.parameter_group_name
  family      = "redis6.x"
  description = "Redis parameter group"
}
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id = var.replication_group_id
  description          = var.replication_group_description
  engine         = var.engine
  engine_version = var.engine_version
  node_type      = var.node_type
  num_cache_clusters = var.num_cache_clusters
  automatic_failover_enabled = true
  parameter_group_name = var.parameter_group_name
  port                 = var.port
  subnet_group_name = aws_elasticache_subnet_group.redis.name
  security_group_ids = [
    var.security_group_id
  ]
  tags = {
    Name = var.replication_group_id
  }
}








# resource "aws_elasticache_replication_group" "name" {
#     replication_group_id          = var.replication_group_id
#     replication_group_description = var.replication_group_description
#     node_type                     = var.node_type
#     number_cache_clusters         = var.number_cache_clusters
#     automatic_failover_enabled    = var.automatic_failover_enabled
#     engine                        = var.engine
#     engine_version                = var.engine_version
#     parameter_group_name          = var.parameter_group_name
#     port                          = var.port
#     subnet_group_name             = var.subnet_group_name
#     security_group_ids            = [var.security_group_id]
#     vpc_id                        = var.vpc_id
#     availability_zones            = var.availability_zones
#     subnet_ids                    = var.subnet_ids
#     tags = {
#         Name = var.replication_group_id
#     }
  
# }