output "db_instance_id" {
  description = "RDS instance identifier."
  value       = module.rds.id
}

output "db_instance_endpoint" {
  description = "RDS instance connection endpoint."
  value       = module.rds.endpoint
}

output "db_instance_address" {
  description = "RDS instance hostname."
  value       = module.rds.address
}

output "db_instance_port" {
  description = "RDS instance port."
  value       = module.rds.port
}
