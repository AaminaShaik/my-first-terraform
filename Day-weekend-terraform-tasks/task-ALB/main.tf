resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "my-custom-alb-vpc"
    }
}
resource "aws_subnet" "my_public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "my-custom-alb-public-subnet"
    }
}
resource "aws_subnet" "pub_subnet-2"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "my-custom-alb-public-subnet-2"
    }
}

resource "aws_subnet" "my_private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
    tags = {
        Name = "my-custom-alb-private-subnet"
    }
}
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "my-custom-alb-igw"
    }
}
resource "aws_route_table" "my_pub_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
    tags = {
        Name = "my-custom-alb-public-route-table"
    }
}
resource "aws_route_table_association" "my_pub_route_table_assoc" {
    subnet_id = aws_subnet.my_public_subnet.id
    route_table_id = aws_route_table.my_pub_route_table.id
}
resource "aws_nat_gateway" "my_nat_gw" {
    allocation_id = aws_eip.my_eip.id
    subnet_id = aws_subnet.my_private_subnet.id
    tags = {
        Name = "my-custom-alb-nat-gateway"
    }
}
resource "aws_eip" "my_eip" {
    tags = {
        Name = "my-custom-alb-eip"
    }
}
resource "aws_route_table" "my_priv_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.my_nat_gw.id
    }
    tags = {
        Name = "my-custom-alb-private-route-table"
    }
}
resource "aws_route_table_association" "my_priv_route_table_assoc" {
    subnet_id = aws_subnet.my_private_subnet.id
    route_table_id = aws_route_table.my_priv_route_table.id
}
resource "aws_security_group" "my_alb_sg" {
    vpc_id = aws_vpc.my_vpc.id
    name = "my-custom-alb-sg"
    description = "Security group for my custom ALB"
    ingress {
        from_port = 80
        to_port = 80
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
resource "aws_instance" "my_instance" {
    ami = "ami-01edba92f9036f76e"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.my_public_subnet.id
    vpc_security_group_ids = [aws_security_group.my_instance_sg.id]
    associate_public_ip_address = true
    tags = {
        Name = "my-custom-alb-instance"
    }
}
resource "aws_security_group" "my_instance_sg" {
    vpc_id = aws_vpc.my_vpc.id
    name = "my-custom-alb-instance-sg"
    description = "Security group for my custom ALB instance"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
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
resource "aws_lb" "my_alb" {
    name = "my-custom-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.my_alb_sg.id]
    subnets = [aws_subnet.my_public_subnet.id, aws_subnet.pub_subnet-2.id]
    tags = {
        Name = "my-custom-alb"
    }
}
resource "aws_lb_target_group" "my_tg" {
    name = "my-custom-alb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.my_vpc.id
    health_check {
        path = "/"
        interval = 30
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2
        matcher = "200-299"
    }
    tags = {
        Name = "my-custom-alb-target-group"
    }

}
resource "aws_lb_listener" "my_listener" {
    load_balancer_arn = aws_lb.my_alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.my_tg.arn
    }
}
resource "aws_lb_target_group_attachment" "my_tg_attachment" {
    target_group_arn = aws_lb_target_group.my_tg.arn
    target_id = aws_instance.my_instance.id
    port = 80
}
