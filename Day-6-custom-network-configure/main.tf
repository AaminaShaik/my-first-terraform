resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = var.tags_vpc
    } 
}
resource "aws_subnet" "my_public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.availability_zone
    tags = {
      Name = var.tags_public_subnet
    }
}
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = var.tags_igw
    }
}
resource "aws_route_table" "my_pub_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = var.tags_public_rt
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
}
resource "aws_route_table_association" "public_assoc" {
    subnet_id      = aws_subnet.my_public_subnet.id
    route_table_id = aws_route_table.my_pub_route_table.id
}
resource "aws_instance" "public-instance" {
    ami = var.public_ami
    instance_type = var.instance_type
    subnet_id = aws_subnet.my_public_subnet.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    associate_public_ip_address = true
    tags = {
      Name = var.public_instance_name
    }
  
}
resource "aws_subnet" "my_private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.availability_zone
    tags = {
      Name = var.tags_private_subnet
    }
}
resource "aws_nat_gateway" "my_nat_gw" {
    allocation_id = aws_eip.my_eip.id
    subnet_id = aws_subnet.my_public_subnet.id
    tags = {
      Name = var.tags_nat_gw
    }
}
resource "aws_eip" "my_eip" {
    tags = {
      Name = var.tags_eip
    }
}
resource "aws_route_table" "my_private_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = var.tags_pvt_rt
    }
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.my_nat_gw.id
    }
    
}
resource "aws_route_table_association" "private_assoc" {
    subnet_id      = aws_subnet.my_private_subnet.id
    route_table_id = aws_route_table.my_private_route_table.id
}
resource "aws_instance" "pvt_instance" {
    ami = var.pvt_ami 
    instance_type = var.instance_type
    subnet_id = aws_subnet.my_private_subnet.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    associate_public_ip_address = false
    tags = {
      Name = var.pvt_instance_name
    }
}
resource "aws_security_group" "my_sg" {
    name = var.sg_name
    description = var.sg_description
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = var.s3_bucket_name
}
