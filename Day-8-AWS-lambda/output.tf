output "cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.my_event_rule.arn
}
output "lambda_function_arn" {
  value = aws_lambda_function.my_lambda.arn
}
output "s3_bucket_name" {
  value = aws_s3_bucket.my_lambda_bucket.bucket
}
output "s3_object_key" {
  value = aws_s3_object.my_lambda_object.key
}