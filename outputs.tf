output "sqs_queue_arns" {
  value       = { for sqs in keys(module.sqs) : sqs => module.sqs[sqs].queue_arns }
  description = "ARNs of the SQS queues, keyed by SQS definition and queue."
}

output "sqs_queue_ids" {
  value       = { for sqs in keys(module.sqs) : sqs => module.sqs[sqs].queue_ids }
  description = "URLs of the SQS queues, keyed by SQS definition and queue."
}

output "sqs_queue_urls" {
  value       = { for sqs in keys(module.sqs) : sqs => module.sqs[sqs].queue_urls }
  description = "URLs of the SQS queues, keyed by SQS definition and queue."
}

output "sqs_queue_tags_all" {
  value       = { for sqs in keys(module.sqs) : sqs => module.sqs[sqs].queue_tags_all }
  description = "Tags assigned to the queues, including provider default tags, keyed by SQS definition and queue."
}

output "sqs_queue_names" {
  value       = { for sqs in keys(module.sqs) : sqs => module.sqs[sqs].queue_names }
  description = "Names of the SQS queues, keyed by SQS definition and queue."
}
