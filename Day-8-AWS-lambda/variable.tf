variable "lambda_role_name" {
  description = "The name of the IAM role for the Lambda function"
  type        = string
  default     = "my_lambda_role"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "my_lambda_function"
}

variable "lambda_handler" {
  description = "The handler for the Lambda function"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda function"
  type        = string
  default     = "python3.8"
}

variable "lambda_zip_file_path" {
  description = "The path to the Lambda function zip file"
  type        = string
  default     = "./lambdafunction.zip"
}