output "name" {
    value = aws_iam_role.my_role.name
}
output "role_arn" {
    value = aws_iam_role.my_role.arn
}
output "iam_policy" {
    value = aws_iam_policy.my_policy.name
}
output "iam_user" {
    value = aws_iam_user.my_user
}
# output "access_key" {
#     value = aws_iam_access_key.my_access_key
# }
output "iam_group" {
    value = aws_iam_group.my_group
}
output "iam_instance_profile" {
    value = aws_iam_instance_profile.my_instance_profile
  
}
