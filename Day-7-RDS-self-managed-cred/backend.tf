terraform {
  backend "s3" {
    bucket = "my-s3-bucket-terraformm1245"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}
