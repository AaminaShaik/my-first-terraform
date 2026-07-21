resource "aws_key_pair" "my-key" {
    key_name = "mykey"
    public_key = file("C:/Users/dell/.ssh/id_rsa.pub")
  
}


# VPC
resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

# Subnet
resource "aws_subnet" "pub_sub1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my-vpc.id
}

# Route Table
resource "aws_route_table" "pub_RT" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Associate Route Table
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.pub_RT.id
}

# Security Group
resource "aws_security_group" "my_Sg" {
  name   = "web"
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
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

# EC2 Instance (Ubuntu)
resource "aws_instance" "server" {
  ami                         = "ami-0b6d9d3d33ba97d99" # Ubuntu AMI us-west-2
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.my-key.key_name
  subnet_id                   = aws_subnet.pub_sub1.id
  vpc_security_group_ids      = [aws_security_group.my_Sg.id]
  associate_public_ip_address = true

tags = {
  Name = "provisioner_server"
}

connection {
    type        = "ssh"
    user        = "ubuntu"                          # ✅ Correct for Ubuntu AMIs
    private_key = file("C:/Users/dell/.ssh/id_rsa")          # Path to private key
    host        = self.public_ip  #or we can use aws_instance.server.public_ip
    timeout     = "3m"
}

provisioner "file" {
    source      = "file10"
    destination = "/home/ubuntu/file10" #destination path on the remote instance copy the file10 from local to remote instance with the name file10
  }

  provisioner "remote-exec" {
    inline = [
      "touch /home/ubuntu/file200",
      "echo 'hello from veera devops cloud nareshit' >> /home/ubuntu/file200"
    ]
  }
   provisioner "local-exec" {
    command = "touch file500" 
 }

}
# File Provisioner → Copies an existing local file (file10) to the EC2.
# Remote-Exec → Creates or modifies files on the EC2 (file200).
# Local-Exec → Creates or modifies files on your computer (file500.txt).
# terraform apply
#         │
#         ▼
# Create EC2
#         │
#         ▼
# SSH Connection
#         │
#         ▼
# File Provisioner
# (Copy file)
#         │
#         ▼
# Remote Exec
# (Run commands inside EC2)
#         │
#         ▼
# Local Exec
# (Run command on your laptop)
# connection → How Terraform logs into the EC2.
# file provisioner → How to copy files to the EC2.
# remote-exec → How to execute commands on the EC2.
# local-exec → How to run commands on your local machine after Terraform creates the resource.