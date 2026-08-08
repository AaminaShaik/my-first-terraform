# variable "redis_port" {
#   description = "The port for the Redis instance"
#   type        = number
#   # default     = 6379
# }
variable "port" {
  description = "The port for the Redis instance"
  type        = number
  default     = 6379
}
variable "replication_group_id" {
  description = "The ID of the Redis replication group"
  type        = string
  # default     = "my-redis-replication-group"
}
variable "replication_group_description" {
  description = "The description of the Redis replication group"
  type        = string
  # default     = "My Redis Replication Group"
}
variable "node_type" {
  description = "The node type for the Redis instance"
  type        = string
  # default     = "cache.t2.micro"
}
variable "num_cache_clusters" {
  description = "The number of cache clusters for the Redis replication group"
  type        = number
  default     = 1
}
variable "automatic_failover_enabled" {
  description = "Whether automatic failover is enabled for the Redis replication group"
  type        = bool
  default     = true
}
variable "engine" {
  description = "The engine for the Redis instance"
  type        = string
  # default     = "redis"
}
variable "engine_version" {
  description = "The version of the Redis engine"
  type        = string
  # default     = "6.x"
}
variable "parameter_group_name" {
  description = "The name of the parameter group for the Redis instance"
  type        = string
  # default     = "default.redis6.x"
}
variable "subnet_group_name" {
  description = "The name of the subnet group for the Redis instance"
  type        = string
  # default     = "my-redis-subnet-group"
}
variable "security_group_id" {
  description = "The ID of the security group for the Redis instance"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets for the Redis instance"
  type        = list(string)
}