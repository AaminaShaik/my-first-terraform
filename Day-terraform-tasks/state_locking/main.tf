resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "my-custom-vpc"
    }
  
}
resource "aws_s3_bucket" "name" {
    bucket = "my-custom-s3-bucket-terraform-state-locking"
    tags = {
        Name = "bucket-terraform-state-locking"
    }
}