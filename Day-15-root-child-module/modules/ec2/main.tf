resource "aws_instance" "my_ec2" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.sub1_id
    vpc_security_group_ids = [var.sg_id]
    tags = {
      Name = var.ec2_tags
    }
}


