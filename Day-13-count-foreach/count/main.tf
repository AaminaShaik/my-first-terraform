resource "aws_instance" "name" {
    ami = "ami-01edba92f9036f76e"
    instance_type = "t2.micro"
    count = length(var.name)
    tags = {
      Name=var.name[count.index]
    }
}
