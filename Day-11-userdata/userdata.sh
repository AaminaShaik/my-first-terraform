#!/bin/bash
yum update -y
yum install git -y
yum install nginx -y 
systemctl start nginx


# User Data is a startup script that runs automatically when an EC2 instance boots for the first time.
#User Data is a script that automatically runs when an EC2 instance launches for the first time. It is commonly used to install software, configure the server, and start services without manually logging into the instance.
#terraform apply
#         │
#         ▼
# Terraform creates EC2
#         │
#         ▼
# EC2 boots
#         │
#         ▼
# User Data script runs automatically
#         │
#         ▼
# Software installed & server configured
#Why Use User Data?
# Automatically configure EC2 at launch.
# No need to SSH into the instance.
# Faster and repeatable deployments.
# Works well with Auto Scaling Groups (ASGs).
# Recommended over Terraform remote-exec for bootstrapping EC2 instances.
