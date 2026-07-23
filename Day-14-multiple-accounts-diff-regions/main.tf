resource "aws_s3_bucket" "bkt-1" {
  bucket = "us-east-1-regions3bucket45743"
  provider = aws.dev-account
}
resource "aws_s3_bucket" "bkt-2" {
    bucket = "us-west-2-region-bucket24356"
    provider = aws.test-account
}
