module "sqs_queue" {
  source              = "../../"
  create_simple_queue = var.create_simple_queue
  create_dlq          = var.create_dlq
  principals_arn      = ["*"]

  queues     = var.sqs_single_queues
  dlq_queues = var.sqs_dlq_queues
}
