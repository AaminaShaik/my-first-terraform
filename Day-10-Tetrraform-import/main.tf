resource "aws_instance" "name" {
  ami = "ami-01edba92f9036f76e"
  instance_type = "t2.micro"
  tags = {
    Name ="import-server"
  }
}

resource "aws_s3_bucket" "name" {
  bucket = "terraform-import-s3-buckett25797"
}




# lifecycle {
#     ignore_changes = ["tags"]
#   }