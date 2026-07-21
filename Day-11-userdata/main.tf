resource "aws_instance" "ec2" {
    ami = "ami-01edba92f9036f76e"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    user_data = file("userdata.sh") #ccalling userdata file here
    user_data_replace_on_change = true
#     user_data = <<-EOF
#     #!/bin/bash
#     yum update -y
#     yum install -y httpd
#     systemctl enable httpd
#     systemctl start httpd
#     echo "<h1>Hello from Terraform User Data</h1>" > /var/www/html/index.html
#   EOF
    tags = {
      Name ="userdata-ec2" 
    }
}
# Important Notes
# User Data runs only on the first boot by default.
# If you update the user_data in Terraform, existing EC2 instances usually won't automatically rerun the script. Depending on your Terraform configuration (such as user_data_replace_on_change), Terraform may replace the instance to apply the new script.
# User Data logs can be found on the instance:
# Amazon Linux: /var/log/cloud-init-output.log
# Ubuntu: /var/log/cloud-init-output.log
