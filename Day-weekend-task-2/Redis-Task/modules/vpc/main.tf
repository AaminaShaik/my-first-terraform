resource "aws_vpc" "my-vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    tags = {
        Name = var.vpc_name
    }
}
resource "aws_subnet" "pvt-subnet-1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.subnet_cidr_1
     availability_zone = var.availability_zone_1a
    tags = {
        Name = var.subnet_name_1
    }
}
resource "aws_subnet" "pvt-subnet-2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.subnet_cidr_2
     availability_zone = var.availability_zone_1b
    tags = {
        Name = var.subnet_name_2
    }
}
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "my-igw"
    }
}
resource "aws_nat_gateway" "my-nat-gateway" {
    vpc_id = aws_vpc.my-vpc.id
    allocation_id = aws_eip.nat-eip.id
    availability_mode = "regional"
    // subnet_id = aws_subnet.pvt-subnet-1.id
    tags = {
        Name = var.nat_gateway_name
    }
}
resource "aws_eip" "nat-eip" {
   // vpc = true
    tags = {
        Name = "nat-eip"
    }
}
resource "aws_route_table" "my-pvt-route-table" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = var.route_table_name
    }
}
resource "aws_route" "my-pvt-route" {
    route_table_id = aws_route_table.my-pvt-route-table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my-nat-gateway.id
}
resource "aws_route_table_association" "my-pvt-route-table-association-1" {
    subnet_id = aws_subnet.pvt-subnet-1.id
    route_table_id = aws_route_table.my-pvt-route-table.id
}
resource "aws_route_table_association" "my-pvt-route-table-association-2" {
    subnet_id = aws_subnet.pvt-subnet-2.id
    route_table_id = aws_route_table.my-pvt-route-table.id
}


# resource "aws_internet_gateway" "my-igw" {
#     vpc_id = aws_vpc.my-vpc.id
#     tags = {
#         Name = "my-igw"
#     }
# }
