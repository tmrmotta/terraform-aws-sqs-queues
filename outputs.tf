/*#---------------------------------------------------------------
# SINGLE QUEUE OUTPUTS
#---------------------------------------------------------------
output "sqs_single_queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.queue.*.id
}

output "sqs_single_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.queue.*.arn
}

output "sqs_single_queue_name" {
  description = "The name of the SQS queue"
  value       = aws_sqs_queue.queue.*.resource
}

output "sqs_single_queue_url" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.queue.*.url
}

#---------------------------------------------------------------
# DLQ SOURCE QUEUE OUTPUTS
#---------------------------------------------------------------
output "sqs_source_queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.source_queue.*.id
}

output "sqs_source_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.source_queue.*.arn
}

output "sqs_source_queue_name" {
  description = "The name of the SQS queue"
  value       = aws_sqs_queue.source_queue.*.resource
}

output "sqs_source_queue_url" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.source_queue.*.url
}

#---------------------------------------------------------------
# DEAD LETTER QUEUE OUTPUTS
#---------------------------------------------------------------
output "deadletter_sqs_queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.deadletter_queue[each.key].id
}

output "deadletter_sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.deadletter_queue[each.key].arn
}

output "deadletter_sqs_queue_name" {
  description = "The name of the SQS queue"
  value       = aws_sqs_queue.deadletter_queue[each.key].resource
}

output "deadletter_sqs_queue_url" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.deadletter_queue[each.key].url
}
*/
