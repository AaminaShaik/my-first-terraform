terraform {
  backend "s3" {
    bucket = "my-custom-nw-s3-bucket-1235683"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}
