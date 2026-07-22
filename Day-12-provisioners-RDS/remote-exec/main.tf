
provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "example" {
  key_name   = "mykey"
  public_key = file("C:/Users/dell/.ssh/id_rsa.pub")
}

resource "aws_security_group" "ec2_sg" {
  name = "sql-runner-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "sql_runner" {
  ami                         = "ami-0b826bb6d96d2afe4"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.example.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "SQL Runner"
  }
}

# Use null_resource to execute the SQL script from ec2 server
resource "null_resource" "remote_sql_exec" {
  depends_on = [aws_instance.sql_runner]   #changed

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/dell/.ssh/id_rsa")
    host        = aws_instance.sql_runner.public_ip
    timeout     = "5m"
  }

#copy init.sql file from local to ec2 remote
  provisioner "file" {
    source      = "init.sql"
    destination = "/tmp/init.sql"
  }

#will run this commands to install mariadb and connect to db and run sql queries
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install mariadb105-server -y",
      "mysql -h my-mysql-db.c0hoyqk2oznr.us-east-1.rds.amazonaws.com -u admin -pPassword123! dev < /tmp/init.sql"
    ]
  }

#it will every time we apply 
  triggers = {
    always_run = timestamp()
  }
}

## resource "aws_key_pair" "example" {
#   key_name   = "task-new"
#   public_key = file("C:/Users/dell/.ssh/id_rsa.pub")
# }
# # Example EC2 instance (replace with yours if already existing)
# resource "aws_instance" "sql_runner" {
#   ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2
#   instance_type          = "t2.micro"
#   key_name               = aws_key_pair.example.key_name             # Replace with your key pair name
#   associate_public_ip_address = true

#   tags = {
#     Name = "SQL Runner"
#   }
# }

# # Deploy SQL remotely using null_resource + remote-exec
# resource "null_resource" "remote_sql_exec" {
#     depends_on = [ aws_instance.sql_runner]
# #   depends_on = [aws_db_instance.mysql_rds, aws_instance.sql_runner]

#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file("C:/Users/dell/.ssh/id_rsa")   # Replace with your PEM file path
#     host        = aws_instance.sql_runner.public_ip
#     timeout = "5m"
#   }

#   provisioner "file" {
#     source      = "init.sql"
#     destination = "/tmp/init.sql"
#   }

#   provisioner "remote-exec" {
#     inline = [
#         "sudo yum install -y mariadb",
#     "mysql --version",
#       #"mysql -h ${aws_db_instance.mysql_rds.address} -u ${jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["username"]} -p${jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["password"]} < /tmp/init.sql"
#       "mysql -h my-mysql-db.c0hoyqk2oznr.us-east-1.rds.amazonaws.com -u admin -pPassword123! dev < /tmp/init.sql"
#     ]
#   }

#   triggers = {
#     always_run = timestamp() #trigger every time apply 
#   }
# }




# # ADD RDS creation script only accessbale interanlly si disable public access 
# # Remote provisioner server also should create insame vpc 
# # enable secrets fro secret manager and call secrets into RDS for this process vpc endpoint is require or nat gateway is required to access secrets to rds internall as secremanger is not in side VPC sefrvice 