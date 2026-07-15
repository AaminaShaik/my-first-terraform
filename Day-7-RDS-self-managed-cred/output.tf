output "vpc_id" {
    value = aws_vpc.my_vpc.id
}
output "subnet_1a_id" {
    value = aws_subnet.my_subnet_1a.id
}
output "subnet_1b_id" {
    value = aws_subnet.my_subnet_1b.id
}
output "security_group_id" {
    value = aws_security_group.my_security_group.id
}
output "s3_bucket_name" {
    value = aws_s3_bucket.my_s3_bucket.bucket
}
output "db_subnet_group_name" {
    value = aws_db_subnet_group.my_db_subnet_group.name
}
output "db_subnet_group_id" {
    value = aws_db_subnet_group.my_db_subnet_group.id
}
output "db_instance_identifier" {
    value = aws_db_instance.my_db_instance.identifier
}
output "db_instance_endpoint" {
    value = aws_db_instance.my_db_instance.endpoint
}
# output "db_instance_id" {
#     value = aws_db_instance.my_db_instance.id
# }
# output "db_instance_arn" {
#     value = aws_db_instance.my_db_instance.arn
# }s
output "db_replica_identifier" {
    value = aws_db_instance.my_db_instance_replica.identifier
}
output "db_replica_endpoint" {
    value = aws_db_instance.my_db_instance_replica.endpoint
}
output "redis_cache_identifier" {
    value = aws_elasticache_cluster.my_elasticache_cluster.id
}
output "redis_cache_endpoint" {
    value = aws_elasticache_cluster.my_elasticache_cluster.cache_nodes[0].address
}
