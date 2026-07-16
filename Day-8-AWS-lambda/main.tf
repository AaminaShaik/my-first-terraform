resource "aws_iam_role" "my_lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "role_attachment" {
  role       = aws_iam_role.my_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  
}
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambdafunction.py"
  output_path = "${path.module}/lambdafunction.zip"
}
  resource "aws_s3_bucket" "my_lambda_bucket" {
  bucket = "my-lambda-bucket-for-lambda-function-code-17536"
}
resource "aws_s3_object" "my_lambda_object" {
  bucket = aws_s3_bucket.my_lambda_bucket.bucket
  key    = "lambdafunction.zip"
  source = var.lambda_zip_file_path
  etag   = filemd5(var.lambda_zip_file_path)
}
resource "aws_lambda_function" "my_lambda" {  
  function_name = var.lambda_function_name
  role          = aws_iam_role.my_lambda_role.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  # filename      = var.lambda_zip_file_path  ensures the correct file is used
  timeout       = 900
  source_code_hash = filebase64sha256(var.lambda_zip_file_path)
  s3_bucket = aws_s3_bucket.my_lambda_bucket.id
  s3_key    = aws_s3_object.my_lambda_object.key
  }


resource aws_cloudwatch_event_rule "my_event_rule" {
  name        = "my-event-rule"
  description = "Trigger Lambda function every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}
resource aws_cloudwatch_event_target "my_event_target" {
  rule      = aws_cloudwatch_event_rule.my_event_rule.name
  target_id = "my-lambda-target"
  arn       = aws_lambda_function.my_lambda.arn
}
resource aws_lambda_permission "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.my_event_rule.arn
}

# explain the code and flow of the code in simple words.
# This Terraform code is used to create an AWS Lambda function and set up the necessary resources for it to run. Here's a simple explanation of the flow of the code:
# 1. **IAM Role Creation**: The code first creates an IAM role (`aws_iam_role.my_lambda_role`) that allows the Lambda function to assume the necessary permissions to execute. The role has a trust policy that allows the Lambda service to assume it.
# 2. **Attach Policy to Role**: Next, it attaches a basic execution policy  (`AWSLambdaBasicExecutionRole`) to the IAM role, which grants the Lambda function permissions to write logs to CloudWatch.
# 3. **Archive Lambda Function**: The code then creates a zip file of the Lambda function code (`lambdafunction.py`) using the `archive_file` data source. This zip file will be used as the deployment package for the Lambda function.
# 4. **S3 Bucket Creation**: An S3 bucket (`aws_s3_bucket.my_lambda_bucket`) is created to store the Lambda function's zip file.
# 5. **Upload Lambda Code to S3**: The zip file of the Lambda function is uploaded to the S3 bucket as an object (`aws_s3_object.my_lambda_object`).
# 6. **Create Lambda Function**: The code then creates the Lambda function (`aws_lambda_function.my_lambda`) using the IAM role, handler, runtime, and the zip file stored in S3. It also sets a timeout for the function execution.
# 7. **CloudWatch Event Rule**: A CloudWatch event rule (`aws_cloudwatch_event_rule.my_event_rule`) is created to trigger the Lambda function every 5 minutes.
# 8. **CloudWatch Event Target**: The event rule is linked to the Lambda function as a target (`aws_cloudwatch_event_target.my_event_target`), so that the Lambda function is invoked according to the schedule defined in the event rule.
# 9. **Lambda Permission**: Finally, a permission (`aws_lambda_permission.allow_eventbridge`) is granted to allow the CloudWatch event rule to invoke the Lambda function.

# also flow how every resource is connected to each other and how the flow is happening give in flow chart.
# The flow of resources is as follows:
# 1. **IAM Role Creation**: 
  #  - `aws_iam_role.my_lambda_role` is created first.    

# lambda_function.py
#        │
#        ▼
# Terraform archive_file creates ZIP locally
#        │
#        ▼
# Terraform uploads ZIP to your existing S3 bucket
#        │
#        ▼
# Terraform tells Lambda: use this bucket + ZIP key
#        │
#        ▼
# Lambda deploys the code and runs lambda_handler()
# give like this in flow chart format.

# Terraform Apply
#       │
#       
# Package Lambda Source Code
#       │
#       
# Create Amazon S3 Bucket
#       │
#       
# Upload Lambda ZIP to S3
#       │
#       
# Create IAM Role
#       │
#       
# Attach Lambda Execution Policy
#       │
#       
# Create AWS Lambda Function
#       │
#       
# Create Amazon EventBridge Schedule
#       │
#       
# Grant EventBridge Permission to Invoke Lambda
#       │
#       
# Associate EventBridge Rule with Lambda
#       │
#       
# Lambda Executes Automatically Every Day at 00:00 UTC

  