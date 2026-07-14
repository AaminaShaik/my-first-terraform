output "public_instance_id" {
     value = aws_instance.public-instance.id
}
output "private_instance_id" {
     value = aws_instance.pvt_instance.id
}
output "vpc_name" {
     value = aws_vpc.my_vpc.tags

}
output "sg_name" {
     value = aws_security_group.my_sg.name
  
}
output "igw_name" {
     value = aws_internet_gateway.my_igw.tags
}
output "nat_gateway_name" {
     value = aws_nat_gateway.my_nat_gw.tags
}
output s3_bucket_name {
     value = aws_s3_bucket.my_s3_bucket.bucket
}

