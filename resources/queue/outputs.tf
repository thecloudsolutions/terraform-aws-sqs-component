output "id" {
  value       = aws_sqs_queue.this.id
  description = "The URL for the created Amazon SQS queue"
}

output "arn" {
  value       = aws_sqs_queue.this.arn
  description = "The ARN of the SQS queue"
}

output "url" {
  value       = aws_sqs_queue.this.url
  description = "Same as id: The URL for the created Amazon SQS queue"
}

output "tags_all" {
  value       = aws_sqs_queue.this.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
}

output "name" {
  value       = aws_sqs_queue.this.name
  description = "Name of the SQS queue."
}
