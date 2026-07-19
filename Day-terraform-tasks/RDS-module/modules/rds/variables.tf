variable "identifier" {
  description = "Unique identifier for the RDS instance."
  type        = string
  # default     = ""
}

variable "db_name" {
  description = "Name of the initial database to create."
  type        = string
}

variable "storage_type" {
  description = "Storage type for the DB instance."
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "Database engine."
  type        = string
  # default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version."
  type        = string
  # default     = "8.0"
}

variable "instance_class" {
  description = "RDS instance type."
  type        = string
  # default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GiB."
  type        = number
  # default     = 20
}

variable "username" {
  description = "Master username."
  type        = string
}

variable "password" {
  description = "Master password."
  type        = string
  sensitive   = true
}

# variable "db_subnet_group_name" {
#   description = "Existing DB subnet group name."
#   type        = string
#   default     = null
# }

# variable "vpc_security_group_ids" {
#   description = "Security group IDs for the RDS instance."
#   type        = list(string)
#   default     = []
# }

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "How long backups are retained."
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot during destroy."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for the RDS instance."
  type        = map(string)
  default     = {}
}
