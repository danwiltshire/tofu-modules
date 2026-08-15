output "schedule_arn" {
  description = "The ARN of the EventBridge schedule."
  value       = aws_scheduler_schedule.this.arn
}

output "schedule_name" {
  description = "The name of the EventBridge schedule."
  value       = aws_scheduler_schedule.this.name
}

output "role_arn" {
  description = "The ARN of the IAM role used by the EventBridge schedule."
  value       = aws_iam_role.scheduler_role.arn
}
