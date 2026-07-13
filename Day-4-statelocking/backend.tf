terraform {
  backend "s3" {
    bucket = "aamina-terraform-state-demo-12345"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}