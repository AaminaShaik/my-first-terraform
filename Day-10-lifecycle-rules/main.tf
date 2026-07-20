resource "aws_instance" "name" {
    ami = "ami-0fd6240f599091088" 
    instance_type = "t2.micro"
    tags = {
      Name="lifecycle"
    }
    lifecycle {
      prevent_destroy = true
    }
    # lifecycle {
    #   create_before_destroy = true
    # }
    # lifecycle {
    #   ignore_changes = [ tags ]
    # }

}