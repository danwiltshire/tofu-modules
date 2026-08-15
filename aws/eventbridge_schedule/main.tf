resource "aws_scheduler_schedule" "this" {
  # checkov:skip=CKV_AWS_297: Don't want KMS
  name                = "${var.label}-${var.schedule_name}"
  schedule_expression = "rate(${var.interval_minutes} minute${var.interval_minutes > 1 ? "s" : ""})"

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = var.lambda_arn
    role_arn = aws_iam_role.scheduler_role.arn

    input = var.payload
  }
}

resource "aws_iam_role" "scheduler_role" {
  name               = "${var.label}-${var.schedule_name}-scheduler-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "scheduler_invoke_lambda" {
  name   = "${var.schedule_name}-invoke-lambda"
  role   = aws_iam_role.scheduler_role.id
  policy = data.aws_iam_policy_document.invoke_lambda.json
}

data "aws_iam_policy_document" "invoke_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction"
    ]

    resources = [
      var.lambda_arn,
      "${var.lambda_arn}:*"
    ]
  }
}
