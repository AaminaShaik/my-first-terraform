output "db_endpoint" {
  value = aws_db_instance.my-db-instance.endpoint
}
output "db_port" {
  value = aws_db_instance.my-db-instance.port
}

output "rds_replica_endpoint" {
  value = aws_db_instance.replica.endpoint
}
output "rds_instance_id" {
  value = aws_db_instance.my-db-instance.id
}
output "rds_replica_instance_id" {
  value = aws_db_instance.replica.id
}
