variable "region" {
  type        = string
  default     = null
  description = "(Optional) Region where this resource is managed. Defaults to the Region set in the provider configuration."
}

variable "queue_url" {
  type        = string
  description = "(Required) The URL of the SQS Queue to which to attach the policy"
}

variable "policy" {
  type        = string
  description = "(Required) The JSON policy for the SQS queue. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
}
