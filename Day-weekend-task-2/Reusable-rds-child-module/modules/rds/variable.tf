variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}
variable "subnet_ids" {
  description = "A list of subnet IDs for the DB subnet group"
  type        = list(string)
}
variable "db_name" {
  description = "The name of the database"
  type        = string
}
variable "db_allocated_storage" {
  description = "The allocated storage size for the database (in GB)"
  type        = number
}
variable "db_storage_type" {
  description = "The storage type for the database (e.g., gp2, io1)"
  type        = string
}
variable "db_engine" {
  description = "The database engine (e.g., mysql, postgres)"
  type        = string
}
variable "db_engine_version" {
  description = "The version of the database engine"
  type        = string
}
variable "db_instance_class" {
  description = "The instance class for the database"
  type        = string
}
variable "db_username" {
  description = "The username for the database"
  type        = string
}
variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}
variable "db_parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
}
variable "sg_id" {
  description = "The ID of the security group"
  type        = string
}
variable "db_name_replica" {
  description = "The name of the database replica"
  type        = string
}