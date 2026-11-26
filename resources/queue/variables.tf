variable "region" {
  type        = string
  default     = null
  description = "(Optional) Region where this resource is managed. Defaults to the Region set in the provider configuration."
}

variable "content_based_deduplication" {
  type        = bool
  default     = null
  description = "(Optional) Enables content-based deduplication for FIFO queues."
}

variable "deduplication_scope" {
  type        = string
  default     = null
  description = "(Optional) Specifies whether message deduplication occurs at the message group or queue level. Valid values are messageGroup and queue (default)."
}

variable "delay_seconds" {
  type        = number
  default     = null
  description = "(Optional) The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds."
}

variable "fifo_queue" {
  type        = bool
  default     = null
  description = "(Optional) Boolean designating a FIFO queue. If not set, it defaults to false making it standard."
}

variable "fifo_throughput_limit" {
  type        = string
  default     = null
  description = "(Optional) Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are perQueue (default) and perMessageGroupId."
}

variable "kms_data_key_reuse_period_seconds" {
  type        = number
  default     = null
  description = "(Optional) The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes)."
}

variable "kms_master_key_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK."
}

variable "max_message_size" {
  type        = number
  default     = null
  description = "(Optional) The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 1048576 bytes (1024 KiB). The default for this attribute is 262144 (256 KiB)."
}

variable "message_retention_seconds" {
  type        = number
  default     = null
  description = "(Optional) The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days)."
}

variable "name" {
  type        = string
  default     = null
  description = "(Optional) The name of the queue. Queue names must be made up of only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 80 characters long. For a FIFO (first-in-first-out) queue, the name must end with the .fifo suffix. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix"
}

variable "name_prefix" {
  type        = string
  default     = null
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name"
}

variable "policy" {
  type        = string
  default     = null
  description = "(Optional) The JSON policy for the SQS queue."
}

variable "receive_wait_time_seconds" {
  type        = number
  default     = null
  description = "(Optional) The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately."
}

variable "redrive_allow_policy" {
  type        = string
  default     = null
  description = "(Optional) The JSON policy to set up the Dead Letter Queue redrive permission."
}

variable "redrive_policy" {
  type        = string
  default     = null
  description = "(Optional) The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string (\"5\")."
}

variable "sqs_managed_sse_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys. Conflicts with kms_master_key_id. Terraform only detects drift when a value is configured."
}

variable "visibility_timeout_seconds" {
  type        = number
  default     = null
  description = "(Optional) The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30."
}

variable "timeouts" {
  type = object({
    create = optional(string)
    # (Optional) Timeout for queue creation. Defaults to 3 minutes.
    update = optional(string)
    # (Optional) Timeout for queue updates. Defaults to 3 minutes.
    delete = optional(string)
    # (Optional) Timeout for queue deletion. Defaults to 3 minutes.
  })
  default     = null
  description = "(Optional) Configuration block for resource operation timeouts."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) A map of tags assigned to all modules."
}
