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
resource "aws_dynamodb_table" "name" {
    name         = "terraform-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
  
    attribute {
      name = "LockID"
      type = "S"
    }
}
