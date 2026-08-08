resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
      "Name" =var.instance_name 
    }
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install -y mysql-client
                mysql -h ${var.db_endpoint} -P ${var.db_port} -u ${var.db_username} -p${var.db_password} -e "SHOW DATABASES;"
                EOF
}
