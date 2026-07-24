output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "sub1_id" {
  value = aws_subnet.sub_1.id
}
output "sub1_cidr" {
    value = aws_subnet.sub_1.cidr_block
}