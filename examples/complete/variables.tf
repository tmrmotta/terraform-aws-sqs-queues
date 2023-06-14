########################################################################################################################
# VARIABLES
########################################################################################################################

variable "sqs_dlq_queues" {
  type = map(object({
    visibility_timeout_seconds    = optional(any)
    message_retention_seconds     = optional(any)
    max_message_size              = optional(any)
    delay_seconds                 = optional(any)
    maxReceiveCount               = optional(any)
    receive_wait_time_seconds     = optional(any)
    sqs_queue_name                = optional(any)
    fifo_queue                    = optional(any)
    content_based_deduplication   = optional(any)
    deduplication_scope           = optional(any)
    dlq_message_retention_seconds = optional(any)
    sqs_managed_sse_enabled       = optional(any)
    iam_role                      = optional(any)
  }))

}
variable "sqs_single_queues" {
  type = map(object({
    visibility_timeout_seconds  = optional(any)
    message_retention_seconds   = optional(any)
    max_message_size            = optional(any)
    receive_wait_time_seconds   = optional(any)
    sqs_queue_name              = optional(any)
    fifo_queue                  = optional(any)
    content_based_deduplication = optional(any)
    deduplication_scope         = optional(any)
    sqs_managed_sse_enabled     = optional(any)
    iam_role                    = optional(any)
  }))
}

variable "create_dlq" {
  description = "Enable SQS DeadLetter Queue"
  type        = bool
  default     = false
}
variable "create_simple_queue" {
  description = "Enable a simple SQS Queue"
  type        = bool
  default     = false
}
