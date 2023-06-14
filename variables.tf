variable "queues" {
  description = "Enable SQS DeadLetter Queue"
  type        = any
}
variable "dlq_queues" {
  description = "Enable a simple SQS Queue"
  type        = any
}
variable "create_dlq" {
  description = "Enable SQS DeadLetter Queue"
  type        = bool
  default     = false
}
variable "create_simple_queue" {
  description = "Enable a simple SQS Queue"
  type        = bool
  default     = true
}
variable "principals_arn" {
  description = "Principals ARN"
  type        = any
}
