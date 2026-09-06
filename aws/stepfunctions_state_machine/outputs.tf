output "state_machine_arn" {
  description = "ARN of the state machine for starting executions or granting access."
  value       = aws_sfn_state_machine.this.arn
}

output "state_machine_name" {
  description = "Name of the created state machine."
  value       = aws_sfn_state_machine.this.name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch log group receiving execution logs."
  value       = aws_cloudwatch_log_group.this.arn
}