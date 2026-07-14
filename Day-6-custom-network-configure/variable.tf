variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
}
variable "tags_vpc" {
  description = "Tags for the VPC"
  type        = string
  default     = ""
}
variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = ""
}
variable "tags_public_subnet" {
  description = "Tags for the public subnet"
  type        = string
  default     = ""
}
variable "tags_igw" {
  description = "Tags for the Internet Gateway"
  type        = string
  default     = ""
}
variable "tags_public_rt" {
  description = "Tags for the public route table"
  type        = string
  default     = ""
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = ""
}

variable "tags_private_subnet" {
  description = "Tags for the private subnet"
  type        = string
  default     = ""
}
variable "availability_zone" {
  description = "The availability zone for the subnets"
  type        = string
  default     = ""
}
variable "tags_nat_gw" {
  description = "Tags for the NAT Gateway"
  type        = string
  default     = ""
}
variable "tags_eip" {
  description = "Tags for the Elastic IP"
  type        = string
  default     = ""
}
variable "sg_name" {
  description = "The name of the security group"
  type        = string
  default     = ""
}
variable "tags_pvt_rt" {
  description = "Tags for the private route table"
  type        = string
  default     = ""
}
variable "sg_description" {
  description = "The description of the security group"
  type        = string
  default     = ""
}
variable "public_instance_name" {
  description = "The name of the public instance"
  type        = string
  default     = ""
}
variable "public_ami" {
  description = "The AMI ID for the public instance"
  type        = string
  default     = ""
}
variable "instance_type" {
  description = "The instance type for the public instance"
  type        = string
  default     = "" 
}
variable "pvt_ami" {
  description = "The AMI ID for the private instance"
  type        = string
  default     = ""
}
variable "pvt_instance_name" {
  description = "The name of the private instance"
  type        = string
  default     = ""
}
variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = ""
}
