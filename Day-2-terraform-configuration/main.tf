resource "aws_vpc" "name" {
    cidr_block =var.cidr_block_vpc
    tags = {
      Name=var.tags_vpc
    }
}
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block =var.cidr_block_subnet
    tags = {
      Name=var.tags_subnet
    }
  
}