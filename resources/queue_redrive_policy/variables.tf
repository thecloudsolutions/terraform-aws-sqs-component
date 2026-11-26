variable "region" {
  type        = string
  default     = null
  description = "(Optional) Region where this resource is managed. Defaults to the Region set in the provider configuration."
}

variable "queue_url" {
  type        = string
  description = "(Required) The URL of the SQS Queue to which to attach the policy"
}

variable "redrive_policy" {
  type        = string
  description = "(Required) The JSON redrive policy for the SQS queue. Accepts two key/val pairs: deadLetterTargetArn and maxReceiveCount. Learn more in the Amazon SQS dead-letter queues documentation."
}
