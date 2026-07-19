resource "aws_iam_role" "my_role" {
    name = "my-iam-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}
resource "aws_iam_policy" "my_policy" {
    name        = "my-iam-policy"
    description = "My custom IAM policy"
    policy      = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "s3:ListAllMyBuckets",
                    "s3:ListBucket",
                    "s3:GetObject",
                    "s3:GetBucket"
                ]
                Effect   = "Allow"
                Resource = "*"
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "my_attachment" {
    role       = aws_iam_role.my_role.name
    policy_arn = aws_iam_policy.my_policy.arn
}
resource "aws_iam_user" "my_user" {
    name = "my-iam-user"
}
resource "aws_iam_user_policy_attachment" "my_user_attachment" {
    user       = aws_iam_user.my_user.name
    policy_arn = aws_iam_policy.my_policy.arn
}
resource "aws_iam_access_key" "my_access_key" {
    user = aws_iam_user.my_user.name
}
resource "aws_iam_group" "my_group" {
    name = "my-iam-group"
}
resource "aws_iam_group_policy_attachment" "my_group_attachment" {
    group      = aws_iam_group.my_group.name
    policy_arn = aws_iam_policy.my_policy.arn
}
resource "aws_iam_user_group_membership" "my_user_group_membership" {
    user = aws_iam_user.my_user.name
    groups = [aws_iam_group.my_group.name]
}
resource "aws_iam_instance_profile" "my_instance_profile" {
    name = "my-iam-instance-profile"
    role = aws_iam_role.my_role.name
}
resource "aws_instance" "my_instance" {
    ami           = "ami-01edba92f9036f76e" # Replace with a valid AMI ID for your region
    instance_type = "t2.micro"
    iam_instance_profile = aws_iam_instance_profile.my_instance_profile.name
    tags = {
        Name = "my-iam-instance"
    }
}
