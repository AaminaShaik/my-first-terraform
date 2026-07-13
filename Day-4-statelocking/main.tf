resource "aws_instance" "name" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
      Name =var.tags
    }
}
resource "aws_s3_bucket" "tf_state" {
  bucket = "aamina-terraform-state-demo-12345"

  tags = {
    Name = "Terraform State Bucket"
  }
}