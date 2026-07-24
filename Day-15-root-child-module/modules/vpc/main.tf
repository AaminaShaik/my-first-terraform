resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
      Name =var.tags
    }
}
resource "aws_subnet" "sub_1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.sub_cidr_block
    tags = {
      Name = var.sub1_tags
    }
}
