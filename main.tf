####################################################################################
# CREATES A SINGLE QUEUE
####################################################################################
resource "aws_sqs_queue" "queue" {
  for_each                    = { for k, v in var.queues : k => v if local.create_simple_queue == true }
  name                        = lookup(each.value, "fifo_queue", each.key) ? "${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : lookup(each.value, "sqs_queue_name", each.key)
  visibility_timeout_seconds  = lookup(each.value, "visibility_timeout_seconds", null)
  message_retention_seconds   = lookup(each.value, "message_retention_seconds", null)
  max_message_size            = lookup(each.value, "max_message_size", null)
  delay_seconds               = lookup(each.value, "delay_seconds", null)
  receive_wait_time_seconds   = lookup(each.value, "receive_wait_time_seconds", null)
  policy                      = data.aws_iam_policy_document.sqs_queue_policy[each.key].json
  fifo_queue                  = lookup(each.value, "fifo_queue", false)
  content_based_deduplication = lookup(each.value, "content_based_deduplication", null)
  deduplication_scope         = lookup(each.value, "deduplication_scope", null)
  sqs_managed_sse_enabled     = lookup(each.value, "sqs_managed_sse_enabled", null)
}


####################################################################################
# CREATES A SIMPLE QUEUE WITH A DEADLETTER QUEUE
####################################################################################
resource "aws_sqs_queue" "source_queue" {
  for_each                    = { for k, v in var.dlq_queues : k => v if local.create_dlq == true }
  name                        = lookup(each.value, "fifo_queue", each.key) ? "${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : lookup(each.value, "sqs_queue_name", each.key)
  visibility_timeout_seconds  = lookup(each.value, "visibility_timeout_seconds", null)
  message_retention_seconds   = lookup(each.value, "message_retention_seconds", null)
  max_message_size            = lookup(each.value, "max_message_size", null)
  delay_seconds               = lookup(each.value, "delay_seconds", null)
  policy                      = data.aws_iam_policy_document.sqs_source_queue_policy[each.key].json
  fifo_queue                  = lookup(each.value, "fifo_queue", false)
  content_based_deduplication = lookup(each.value, "content_based_deduplication", each.key)
  deduplication_scope         = lookup(each.value, "deduplication_scope", null)
  sqs_managed_sse_enabled     = lookup(each.value, "sqs_managed_sse_enabled", null)

  redrive_policy = jsonencode({
    deadLetterTargetArn = "arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:${lookup(each.value, "fifo_queue", each.key) ? "dlq-${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : "dlq-${lookup(each.value, "sqs_queue_name", each.key)}"}"
    maxReceiveCount     = lookup(each.value, "maxReceiveCount", 3)
  })

  depends_on = [
    aws_sqs_queue.deadletter_queue
  ]
}

resource "aws_sqs_queue" "deadletter_queue" {
  for_each                    = { for k, v in var.dlq_queues : k => v if local.create_dlq == true }
  name                        = lookup(each.value, "fifo_queue", each.key) ? "dlq-${lookup(each.value, "sqs_queue_name", each.key)}.fifo" : "dlq-${lookup(each.value, "sqs_queue_name", each.key)}"
  policy                      = data.aws_iam_policy_document.sqs_dlq_queue_policy[each.key].json
  fifo_queue                  = lookup(each.value, "fifo_queue", false)
  visibility_timeout_seconds  = lookup(each.value, "visibility_timeout_seconds", null)
  message_retention_seconds   = lookup(each.value, "message_retention_seconds", null)
  content_based_deduplication = lookup(each.value, "content_based_deduplication", null)
  deduplication_scope         = lookup(each.value, "deduplication_scope", null)
  sqs_managed_sse_enabled     = lookup(each.value, "sqs_managed_sse_enabled", null)

  redrive_allow_policy = jsonencode({
    redrivePermission = "allowAll"
  })
}
