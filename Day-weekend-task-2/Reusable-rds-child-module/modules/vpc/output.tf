output "vpc_id" {
  value = aws_vpc.my-vpc.id
}
output "subnet_id_1" {
  value = aws_subnet.pvt-subnet-1.id
}
output "subnet_id_2"{
    value =aws_subnet.pvt-subnet-2.id
}
output "nat_gateway_id" {
    value = aws_nat_gateway.my-nat-gateway.id
}
