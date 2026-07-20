data "aws_ami" "name" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
    }
}

data "aws_ec2_instance_type" "name" {
     instance_type = "t3.micro"
}
data "aws_subnet" "name" {
  filter {
    name = "tag:Name"
    values = ["subnet-1"]
  }
}
data "aws_security_group" "name" {
  filter {
    name ="tag:Name"
    values = ["my-sg"]
  }
}

resource "aws_instance" "name" {
  ami = data.aws_ami.name.id
  instance_type = data.aws_ec2_instance_type.name.id
  subnet_id = data.aws_subnet.name.id
  vpc_security_group_ids = [data.aws_security_group.name.id]
  tags = {
    Name="data-source-ec2"
  }
}
