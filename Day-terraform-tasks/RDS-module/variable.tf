variable "identifier" {
  description = "Unique identifier for the RDS instance."
  type        = string
}

variable "db_name" {
  description = "Name of the initial database to create."
  type        = string
#   default     = null
}

variable "engine" {
  description = "Database engine, such as mysql or postgres."
  type        = string
#   default     = "mysql"
}

variable "engine_version" {
  description = "Version of the selected database engine."
  type        = string
#   default     = null
}

variable "instance_class" {
  description = "RDS instance type."
  type        = string
#   default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage allocated to the instance in GiB."
  type        = number
#   default     = 20
}
variable "storage_type" {
    description = "storage_type"
  
}
variable "username" {
  description = "Master username for the database."
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Master password for the database. Provide this through a tfvars file or environment variable."
  type        = string
  sensitive   = true
}

variable "backup_retention_period" {
    description = "backup_retention_period"
    type = number
    # default = 7
  
}
# variable "db_subnet_group_name" {
#   description = "Existing DB subnet group name."
#   type        = string
# #   default     = null
# }

# variable "vpc_security_group_ids" {
#   description = "Security groups to associate with the RDS instance."
#   type        = list(string)
#   default     = []
# }

variable "publicly_accessible" {
  description = "Whether the instance receives a public IP address."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot when Terraform destroys the instance. Suitable for practice only."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the RDS instance."
  type        = map(string)
  default     = {}
}
