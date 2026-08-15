data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "${var.label}-replication-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"
    actions = [
      "events:PutRule",
      "events:PutTargets",
      "events:DeleteRule",
      "events:RemoveTargets"
    ]
    resources = [
      "arn:aws:events:*:${data.aws_caller_identity.current.account_id}:rule/${var.event_bus_name}/GlobalEndpointManagedRule-*"
    ]
  }
  statement {
    actions = [
      "events:PutEvents"
    ]
    resources = [
      "arn:aws:events:*:${data.aws_caller_identity.current.account_id}:event-bus/${var.event_bus_name}"
    ]
  }
  statement {
    actions = [
      "iam:PassRole"
    ]
    resources = [
      aws_iam_role.role.arn
    ]
    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"

      values = [
        "events.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role_policy" "event_replication" {
  name = "event-replication"
  role = aws_iam_role.role.id

  policy = data.aws_iam_policy_document.policy.json
}

resource "aws_cloudwatch_metric_alarm" "high_latency" {
  alarm_name          = "${var.label}-high-latency"
  alarm_description   = "High latency in Amazon EventBridge"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "IngestionToInvocationStartLatency"
  namespace           = "AWS/Events"
  period              = 60
  statistic           = "Average"
  threshold           = 30000
  treat_missing_data  = "breaching"
  # dimensions = {
  #   EventBusName = var.event_bus_name
  # }
}

resource "aws_route53_health_check" "primary" {
  type                            = "CLOUDWATCH_METRIC"
  cloudwatch_alarm_name           = aws_cloudwatch_metric_alarm.high_latency.alarm_name
  cloudwatch_alarm_region         = var.primary_region
  insufficient_data_health_status = "Unhealthy"

  tags = {
    Name = "${var.label}-latency"
  }
}

resource "aws_cloudwatch_event_endpoint" "this" {
  name     = var.label
  role_arn = aws_iam_role.role.arn

  event_bus {
    event_bus_arn = "arn:aws:events:${var.primary_region}:${data.aws_caller_identity.current.account_id}:event-bus/${var.event_bus_name}"
  }

  event_bus {
    event_bus_arn = "arn:aws:events:${var.secondary_region}:${data.aws_caller_identity.current.account_id}:event-bus/${var.event_bus_name}"
  }

  replication_config {
    state = "ENABLED"
  }

  routing_config {
    failover_config {
      primary {
        health_check = aws_route53_health_check.primary.arn
      }

      secondary {
        route = var.secondary_region
      }
    }
  }
}
