variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "vpc_name" {
  description = "The name for the VPC"
  type        = string
}
variable "subnet_cidr_1" {
  description = "The CIDR block for the first private subnet"
  type        = string
}
variable "subnet_name_1" {
  description = "The name for the first private subnet"
  type        = string
}
variable "subnet_cidr_2" {
  description = "The CIDR block for the second private subnet"
  type        = string
}
variable "availability_zone_1a" {
  description = "The availability zone for the first private subnet"
  type        = string
  
}

variable "subnet_name_2" {
  description = "The name for the second private subnet"
  type        = string
}
variable "availability_zone_1b" {
  description = "The availability zone for the second private subnet"
  type        = string
  
}
variable "route_table_name" {
  description = "The name for the route table"
  type        = string
}
variable "nat_gateway_name" {
  description = "The name for the NAT gateway"
  type        = string
}