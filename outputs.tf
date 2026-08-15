output "endpoint_url" {
  description = "The HTTPS URL of the EventBridge global endpoint."
  value       = aws_cloudwatch_event_endpoint.this.endpoint_url
}

output "endpoint_id" {
  description = "The generated endpoint identifier from the EventBridge global endpoint URL."
  value       = regex("https://(.+?)\\.endpoint", aws_cloudwatch_event_endpoint.this.endpoint_url)[0]
}
