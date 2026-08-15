output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "ARN of the IAM role used by the Lambda function."
}

output "function_arn" {
  value       = aws_lambda_function.this.arn
  description = "ARN of the Lambda function."
}

output "function_url" {
  value       = try(aws_lambda_function_url.this[0].function_url, null)
  description = "Function URL for the Lambda, when IAM auth is enabled."
}
