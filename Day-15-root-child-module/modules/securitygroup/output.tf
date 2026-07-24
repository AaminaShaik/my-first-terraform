output "sg_name" {
  value = aws_security_group.my_sg.name
}
output "sg_description" {
    value = aws_security_group.my_sg.description
}
output "vpc_id" {
    value = aws_security_group.my_sg.vpc_id
}
output "sg_id" {
    value = aws_security_group.my_sg.id
  
}