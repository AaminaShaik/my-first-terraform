variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "subnet_cidr_1" {
  description = "The CIDR block for the first subnet in availability zone 1a"
  type        = string
  default     = "10.0.1.0/24"
}
variable "subnet_name_1" {
  description = "The name of the first subnet in availability zone 1a"
  type        = string
  default     = "my-subnet-1a"
}
variable "availability_zone_1a" {
  description = "The availability zone for the first subnet"
  type        = string
  default     = "us-east-1a"
}
variable "subnet_cidr_2" {
  description = "The CIDR block for the second subnet in availability zone 1b"
  type        = string
  default     = "10.0.0.0/24"
}
variable "subnet_name_2" {
  description = "The name of the second subnet in availability zone 1b"
  type        = string
  default     = "my-subnet-1b"
}
variable "availability_zone_1b" {
  description = "The availability zone for the second subnet"
  type        = string
  default     = "us-east-1b"
}
variable "route_table_name" {
  description = "The name of the route table"
  type        = string
  default     = "my-route-table"
}
variable "nat_gateway_name" {
  description = "The name of the NAT gateway"
  type        = string
  default     = "my-nat-gateway"
}

variable "sg_name" {
  description = "The name for the security group"
  type        = string
  default     = "my-security-group"
}
variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance"
  type        = string
  default     = "ami-0bdc7d025135d7b49"
}
variable "instance_type" {
  description = "The type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}
variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "my-ec2-instance"
}
# variable "redis_endpoint" {
#   description = "The endpoint of the Redis instance"
#   type        = string
# }
variable "redis_port" {
  description = "The port of the Redis instance"
  type        = number
  default     = 6379
}
variable "replication_group_id" {
  type    = string
  default = "my-redis"
}

variable "replication_group_description" {
  type    = string
  default = "Redis replication group"
}

variable "engine" {
  type    = string
  default = "redis"
}

variable "engine_version" {
  type    = string
  default = "7.1"
}

variable "node_type" {
  type    = string
  default = "cache.t3.micro"
}

variable "num_cache_clusters" {
  type    = number
  default = 2
}

variable "automatic_failover_enabled" {
  type    = bool
  default = true
}

variable "parameter_group_name" {
  type    = string
  default = "my-redis-parameter-group"
}

variable "port" {
  type    = number
  default = 6379
}

variable "subnet_group_name" {
  type    = string
  default = "my-redis-subnet-group"
}