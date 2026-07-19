resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "my-custom-vpc"
    }
}
resource "aws_subnet" "pub_subnet" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "my-custom-pub-subnet"
    }
}
resource "aws_subnet" "priv_subnet" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
    tags = {
        Name = "my-custom-priv-subnet"
    }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "my-custom-igw"
    }
}
resource "aws_route_table" "pub_route_table" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "my-custom-pub-route-table"
    }
}
resource "aws_route_table_association" "pub_route_table_assoc" {
    subnet_id = aws_subnet.pub_subnet.id
    route_table_id = aws_route_table.pub_route_table.id
}
resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    # subnet_id = aws_subnet.priv_subnet.id
    vpc_id = aws_vpc.name.id
    availability_mode = "regional"
    tags = {
        Name = "my-custom-nat-gateway"
    }
}
resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
        Name = "my-custom-nat-eip"
    }
}
resource "aws_route_table" "priv_route_table" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
        Name = "my-custom-priv-route-table"
    }
}
resource "aws_route_table_association" "priv_route_table_assoc" {
    subnet_id = aws_subnet.priv_subnet.id
    route_table_id = aws_route_table.priv_route_table.id
}