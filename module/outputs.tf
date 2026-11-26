output "queue_arns" {
  value       = { for queue in keys(module.queue) : queue => module.queue[queue].arn }
  description = "ARNs of the SQS queues."
}

output "queue_ids" {
  value       = { for queue in keys(module.queue) : queue => module.queue[queue].id }
  description = "URLs of the SQS queues."
}

output "queue_urls" {
  value       = { for queue in keys(module.queue) : queue => module.queue[queue].url }
  description = "URLs of the SQS queues."
}

output "queue_tags_all" {
  value       = { for queue in keys(module.queue) : queue => module.queue[queue].tags_all }
  description = "Tags assigned to the queues, including provider default tags."
}

output "queue_names" {
  value       = { for queue in keys(module.queue) : queue => module.queue[queue].name }
  description = "Names of the SQS queues."
}
