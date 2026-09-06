locals {
  label          = "${var.context.application}-${var.context.environment}-${var.context.component}"
  log_group_name = coalesce(var.log_group_name, "/aws/vendedlogs/states/${local.label}")
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "logging" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogDelivery",
      "logs:GetLogDelivery",
      "logs:UpdateLogDelivery",
      "logs:DeleteLogDelivery",
      "logs:ListLogDeliveries",
      "logs:PutResourcePolicy",
      "logs:DescribeResourcePolicies",
      "logs:DescribeLogGroups"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "this" {
  name               = "${local.label}-state-machine-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "logging" {
  name   = "state-machine-logging"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.logging.json
}

resource "aws_iam_role_policy" "user" {
  for_each = var.policy_documents

  name   = each.key
  role   = aws_iam_role.this.id
  policy = each.value
}

resource "aws_cloudwatch_log_group" "this" {
  # checkov:skip=CKV_AWS_158: Don't need KMS.
  name              = local.log_group_name
  retention_in_days = var.log_retention_in_days
}

resource "aws_sfn_state_machine" "this" {
  name       = local.label
  definition = var.definition
  role_arn   = aws_iam_role.this.arn
  type       = var.type

  logging_configuration {
    include_execution_data = true
    level                  = "ALL"
    log_destination        = "${aws_cloudwatch_log_group.this.arn}:*"
  }

  tracing_configuration {
    enabled = true
  }
}