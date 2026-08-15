output "endpoint_url" {
  value = aws_cloudwatch_event_endpoint.this.endpoint_url
}

output "endpoint_id" {
  value = regex("https://(.+?)\\.endpoint", aws_cloudwatch_event_endpoint.this.endpoint_url)[0]
}
