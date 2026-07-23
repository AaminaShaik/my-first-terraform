resource "aws_security_group" "my_sg" {
    name = "my_for_loop_sg"
    description = "allow"
    # vpc_id = aws_vpc.my_vpc.id
    # ingress {
    #     description = "SSH inbound rule"
    #     from_port = 22
    #     to_port = 22
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }
    #  ingress {
    #     description = "HTTP inbound rule"
    #     from_port = 80
    #     to_port = 80
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }
    #  ingress {
    #     description = "HTTPS inbound rule"
    #     from_port = 443
    #     to_port = 443
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }
    ingress = [ 
        for port in [80,443,8080,9000,3360,8081,8082]:{
        description = "inbound rules"
        from_port = port
        to_port = port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }
    ]
    egress {
        description = "outbound rule"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}