data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_event_bus" "this" {
  name = "${var.label}-${var.event_bus_name}"

  log_config {
    include_detail = var.logging.include_detail ? "FULL" : "NONE"
    level          = var.logging.level
  }
}

resource "aws_cloudwatch_log_delivery_source" "info" {
  name         = "${aws_cloudwatch_event_bus.this.name}-info-logs"
  log_type     = "INFO_LOGS"
  resource_arn = aws_cloudwatch_event_bus.this.arn
}

resource "aws_cloudwatch_log_delivery_source" "error" {
  name         = "${aws_cloudwatch_event_bus.this.name}-error-logs"
  log_type     = "ERROR_LOGS"
  resource_arn = aws_cloudwatch_event_bus.this.arn
}

resource "aws_cloudwatch_log_delivery_source" "trace" {
  name         = "${aws_cloudwatch_event_bus.this.name}-trace-logs"
  log_type     = "TRACE_LOGS"
  resource_arn = aws_cloudwatch_event_bus.this.arn
}

resource "aws_cloudwatch_log_group" "this" {
  # checkov:skip=CKV_AWS_158: Don't want KMS
  name              = var.logging.log_group_name != null ? var.logging.log_group_name : "/aws/vendedlogs/events/event-bus/${aws_cloudwatch_event_bus.this.name}"
  retention_in_days = var.logging.retention_in_days
}

data "aws_iam_policy_document" "logs" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["${aws_cloudwatch_log_group.this.arn}:log-stream:*"]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [
        aws_cloudwatch_log_delivery_source.info.arn,
        aws_cloudwatch_log_delivery_source.error.arn,
        aws_cloudwatch_log_delivery_source.trace.arn
      ]
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  policy_document = data.aws_iam_policy_document.logs.json
  policy_name     = "${aws_cloudwatch_event_bus.this.name}-logs"
}

resource "aws_cloudwatch_log_delivery_destination" "this" {
  name = "${aws_cloudwatch_event_bus.this.name}-CWLogs"

  delivery_destination_configuration {
    destination_resource_arn = aws_cloudwatch_log_group.this.arn
  }
}

resource "aws_cloudwatch_log_delivery" "info" {
  delivery_destination_arn = aws_cloudwatch_log_delivery_destination.this.arn
  delivery_source_name     = aws_cloudwatch_log_delivery_source.info.name
}

resource "aws_cloudwatch_log_delivery" "error" {
  delivery_destination_arn = aws_cloudwatch_log_delivery_destination.this.arn
  delivery_source_name     = aws_cloudwatch_log_delivery_source.error.name

  depends_on = [aws_cloudwatch_log_delivery.info]
}

resource "aws_cloudwatch_log_delivery" "trace" {
  delivery_destination_arn = aws_cloudwatch_log_delivery_destination.this.arn
  delivery_source_name     = aws_cloudwatch_log_delivery_source.trace.name

  depends_on = [aws_cloudwatch_log_delivery.error]
}
