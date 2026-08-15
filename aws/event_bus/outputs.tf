output "event_bus_name" {
  description = "The name of the EventBridge event bus."
  value       = aws_cloudwatch_event_bus.this.name
}

output "event_bus_arn" {
  description = "The ARN of the EventBridge event bus."
  value       = aws_cloudwatch_event_bus.this.arn
}
