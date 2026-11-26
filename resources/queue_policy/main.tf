resource "aws_sqs_queue_policy" "this" {
  region    = var.region
  queue_url = var.queue_url
  policy    = var.policy
}
