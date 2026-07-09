variable "cidr_block_vpc" {
    description = "cidr for vpc"
    type = string
    default = ""
}
variable "tags_vpc" {
    description = "tags for vpc"
    type = string
    default = ""
}
variable "cidr_block_subnet" {
  description = "cidr for subnet"
  type = string
  default =""
}
variable "tags_subnet" {
  description = "tag for subnet"
  type = string
  default = ""
}