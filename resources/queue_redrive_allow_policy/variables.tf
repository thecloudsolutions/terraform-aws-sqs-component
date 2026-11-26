variable "region" {
  type        = string
  default     = null
  description = "(Optional) Region where this resource is managed. Defaults to the Region set in the provider configuration."
}

variable "queue_url" {
  type        = string
  description = "(Required) The URL of the SQS Queue to which to attach the policy"
}

variable "redrive_allow_policy" {
  type        = string
  description = "(Required) The JSON redrive allow policy for the SQS queue. Learn more in the Amazon SQS dead-letter queues documentation."
}
