output "id" {
  description = "RDS instance identifier."
  value       = aws_db_instance.this.id
}

output "endpoint" {
  description = "RDS connection endpoint."
  value       = aws_db_instance.this.endpoint
}

output "address" {
  description = "RDS instance hostname."
  value       = aws_db_instance.this.address
}

output "port" {
  description = "RDS instance port."
  value       = aws_db_instance.this.port
}
