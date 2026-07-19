terraform {
  backend "s3" {
    bucket = "my-custom-s3-bucket-terraform-state-locking"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
    dynamodb_table = "terraform-locks" #dynamodb table to avoid concurrent modification of state file
    encrypt = true
  }
}
#to lock the state file in s3 bucket we can use either of the two methods mentioned above.
#s3 locking file is a native feature of s3 bucket and is available in terraform version >=1.10
#dynamodb table locking is a feature of terraform and is available in terraform version <1.10
