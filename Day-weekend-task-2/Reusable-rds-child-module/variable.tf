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

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
  default     = "mydatabase"
}
variable "db_username" {
  description = "The username for the RDS database"
  type        = string
  default     = "admin"
}
variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  default     = "password123"
}
variable "db_allocated_storage" {
  description = "The allocated storage for the RDS database in GB"
  type        = number
  default     = 20
}
variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
  default     = "mydbsubnetgroup"
}
variable "db_storage_type" {
  description = "The storage type for the RDS database"
  type        = string
  default     = "gp2"
}
variable "db_engine" {
  description = "The database engine for the RDS database"
  type        = string
  default     = "mysql"
}
variable "db_engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "8.0"
}
variable "db_instance_class" {
  description = "The instance class for the RDS database"
  type        = string
  default     = "db.t3.micro"
}
variable "db_parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
  default     = "mydbparametergroup"
}
variable "db_name_replica" {
  description = "The name of the RDS database replica"
  type        = string
  default     = "mydatabase-replica"
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