variable "sqs_map" {
  type = map(object({
    queues = optional(map(object({
      region                            = optional(string)
      content_based_deduplication       = optional(bool)
      deduplication_scope               = optional(string)
      delay_seconds                     = optional(number)
      fifo_queue                        = optional(bool)
      fifo_throughput_limit             = optional(string)
      kms_data_key_reuse_period_seconds = optional(number)
      kms_master_key_id                 = optional(string)
      max_message_size                  = optional(number)
      message_retention_seconds         = optional(number)
      name                              = optional(string)
      name_prefix                       = optional(string)
      policy                            = optional(string)
      # (Optional) Inline policy. Do not combine with queue_policies targeting this queue.
      receive_wait_time_seconds = optional(number)
      redrive_allow_policy      = optional(string)
      # (Optional) Inline redrive allow policy. Do not combine with redrive_allow_policies targeting this queue.
      redrive_policy = optional(string)
      # (Optional) Inline redrive policy. Do not combine with redrive_policies targeting this queue.
      sqs_managed_sse_enabled    = optional(bool)
      visibility_timeout_seconds = optional(number)

      timeouts = optional(object({
        create = optional(string)
        update = optional(string)
        delete = optional(string)
      }))

      tags = optional(map(string))
    })), {})

    queue_policies = optional(map(object({
      region = optional(string)
      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.
      policy    = string
      queue_url = optional(string)
      # (Optional) Queue URL. Takes precedence over queue_custom_name.
      queue_custom_name = optional(string)
      # (Optional) Key in queues within this sqs_map entry. Required when queue_url is omitted.
    })), {})

    redrive_allow_policies = optional(map(object({
      region = optional(string)
      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.
      queue_url = optional(string)
      # (Optional) Queue URL. Takes precedence over queue_custom_name.
      queue_custom_name = optional(string)
      # (Optional) Key in queues within this sqs_map entry. Required when queue_url is omitted.
      redrive_allow_policy = optional(string)
      # (Optional) JSON policy. Takes precedence over the structured policy fields.
      redrive_permission = optional(string)
      # (Optional) Required when redrive_allow_policy is omitted. Valid values are allowAll, denyAll and byQueue.
      source_queue_arns = optional(set(string))
      # (Optional) Source queue ARNs for byQueue. Takes precedence over source_queue_custom_names.
      source_queue_custom_names = optional(set(string), [])
      # (Optional) Source queue keys in queues within this sqs_map entry for byQueue when source_queue_arns is omitted.
    })), {})

    redrive_policies = optional(map(object({
      region = optional(string)
      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.
      queue_url = optional(string)
      # (Optional) Source queue URL. Takes precedence over queue_custom_name.
      queue_custom_name = optional(string)
      # (Optional) Source queue key in queues within this sqs_map entry. Required when queue_url is omitted.
      redrive_policy = optional(string)
      # (Optional) JSON policy. Takes precedence over the structured policy fields.
      dead_letter_target_arn = optional(string)
      # (Optional) Destination queue ARN. Takes precedence over dead_letter_target_custom_name.
      dead_letter_target_custom_name = optional(string)
      # (Optional) Destination queue key in queues within this sqs_map entry. Required when redrive_policy and dead_letter_target_arn are omitted.
      max_receive_count = optional(number)
      # (Optional) Required when redrive_policy is omitted. Number of receives before moving a message to the destination queue.
    })), {})
  }))

  description = "Keyed collection of sqs definitions"
}
