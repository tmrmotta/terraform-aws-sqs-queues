data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

####################################################################################
## SQS Single Queue Policy
####################################################################################
data "aws_iam_policy_document" "sqs_queue_policy" {
  for_each = { for k, v in var.queues : k => v if local.create_simple_queue == true }
  statement {
    actions = [
      "SQS:*"
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.principals_arn

    }
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : lookup(each.value, "sqs_queue_name", each.key)}"]
    sid       = "Allow_Full_Access_To_Owners"
  }
  statement {
    actions = [
      "SQS:SendMessage"
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.principals_arn
    }
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : lookup(each.value, "sqs_queue_name", each.key)}"]
    sid       = "Allow_Sending_Messages"
  }
  statement {
    actions = [
      "SQS:ReceiveMessage",
      "SQS:DeleteMessage",
      "SQS:ChangeMessageVisibility",
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.principals_arn
    }
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : lookup(each.value, "sqs_queue_name", each.key)}"]
    sid       = "Allow_Changes_Messages_Status"
  }
}

####################################################################################
## SQS Source Queue Policy
####################################################################################
data "aws_iam_policy_document" "sqs_source_queue_policy" {
  for_each = { for k, v in var.dlq_queues : k => v if local.create_simple_queue == true }
  statement {
    actions = [
      "SQS:*"
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.principals_arn

    }
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : lookup(each.value, "sqs_queue_name", each.key)}"]
    sid       = "Allow_Full_Access_To_Owners"
  }
  statement {
    actions = [
      "SQS:SendMessage"
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.principals_arn
    }
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : lookup(each.value, "sqs_queue_name", each.key)}"]
    sid       = "Allow_Sending_Messages"
  }
  statement {
    actions = [
      "SQS:ReceiveMessage",
      "SQS:DeleteMessage",
      "SQS:ChangeMessageVisibility",
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.principals_arn
    }
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : lookup(each.value, "sqs_queue_name", each.key)}"]
    sid       = "Allow_Changes_Messages_Status"
  }
}

####################################################################################
## SQS DLQ Policy
####################################################################################
data "aws_iam_policy_document" "sqs_dlq_queue_policy" {
  for_each = { for k, v in var.dlq_queues : k => v if local.create_dlq == true }
  statement {
    actions = [
      "SQS:*"
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.principals_arn
    }
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "dlq-${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : "dlq-${lookup(each.value, "sqs_queue_name", each.key)}"}"]
    sid       = "Allow_Full_Access_To_Owners"
  }
  statement {
    actions = [
      "SQS:SendMessage"
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.principals_arn
    }
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "dlq-${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : "dlq-${lookup(each.value, "sqs_queue_name", each.key)}"}"]
    sid       = "Allow_Sending_Messages"
  }
  statement {
    actions = [
      "SQS:ReceiveMessage",
      "SQS:DeleteMessage",
      "SQS:ChangeMessageVisibility",
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.principals_arn
    }
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "dlq-${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : "dlq-${lookup(each.value, "sqs_queue_name", each.key)}"}"]
    sid       = "Allow_Changes_Messages_Status"
  }
}
