variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}
variable "tags_vpc" {
  description = "Tags for the VPC"
  type        = string
  default     = ""
}
variable "subnet_cidr_1a" {
  description = "CIDR block for the first subnet"
  type        = string
  default     = ""
}
variable "subnet_cidr_1b" {
  description = "CIDR block for the second subnet"
  type        = string
  default     = ""
}
variable "availability_zone_1a" {
  description = "Availability zone for the first subnet"
  type        = string
  default     = ""
}
variable "availability_zone_1b" {
  description = "Availability zone for the second subnet"
  type        = string
  default     = ""
}
variable "tags_subnet_1a" {
  description = "Tags for the first subnet"
  type        = string
  default     = ""
}
variable "tags_subnet_1b" {
  description = "Tags for the second subnet"
  type        = string
  default     =  ""
}
variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = ""
}
variable "security_group_description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group for my RDS instance"
}
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = ""
}
variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
  default     = ""
}
variable "db_subnet_group_description" {
  description = "Description of the DB subnet group"
  type        = string
  default     = "DB subnet group for my RDS instance"
}
variable "db_allocated_storage" {
  description = "Allocated storage for the RDS instance (in GB)"
  type        = string
  default     = ""
}
variable "db_engine" {
  description = "Database engine for the RDS instance"
  type        = string
  default     = ""
}
variable "db_engine_version" {
  description = "Database engine version for the RDS instance"
  type        = string
  default     = ""
}
variable "db_instance_class" {
  description = "Instance class for the RDS instance"
  type        = string
  default     = ""
}
variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = ""
}
variable "db_username" {
  description = "Username for the database"
  type        = string
  default     = ""
}
variable "db_password" {
  description = "Password for the database"
  type        = string
  default     = ""
}
variable "db_parameter_group_name" {
  description = "Name of the DB parameter group"
  type        = string
  default     = ""
}
variable "db_replica" {
  description = "Identifier for the RDS replica"
  type        = string
  default     = ""
}
variable "redis_cluster_id" {
  description = "Identifier for the Redis cluster"
  type        = string
  default     = ""
}
variable "redis_engine" {
    description = "Engine for the Redis cluster"
    type        = string
    default     = ""  
}
variable "redis_engine_version" {
    description = "Engine version for the Redis cluster"
    type        = string
    default     = ""  
}
variable "redis_node_type" {
    description = "Node type for the Redis cluster"
    type        = string
    default     = ""  
}
variable "redis_parameter_group_name" {
    description = "Parameter group name for the Redis cluster"
    type        = string
    default     = ""  
  
}
variable "redis_num_cache_nodes" {
    description = "Number of cache nodes for the Redis cluster"
    type        = string
    default     = ""
}
