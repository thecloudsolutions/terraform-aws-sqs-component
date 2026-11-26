module "queue" {
  source = "../resources/queue"

  for_each = var.queues

  region                            = lookup(each.value, "region", null)
  content_based_deduplication       = lookup(each.value, "content_based_deduplication", null)
  deduplication_scope               = lookup(each.value, "deduplication_scope", null)
  delay_seconds                     = lookup(each.value, "delay_seconds", null)
  fifo_queue                        = lookup(each.value, "fifo_queue", null)
  fifo_throughput_limit             = lookup(each.value, "fifo_throughput_limit", null)
  kms_data_key_reuse_period_seconds = lookup(each.value, "kms_data_key_reuse_period_seconds", null)
  kms_master_key_id                 = lookup(each.value, "kms_master_key_id", null)
  max_message_size                  = lookup(each.value, "max_message_size", null)
  message_retention_seconds         = lookup(each.value, "message_retention_seconds", null)
  name                              = lookup(each.value, "name", null)
  name_prefix                       = lookup(each.value, "name_prefix", null)
  policy                            = lookup(each.value, "policy", null)
  receive_wait_time_seconds         = lookup(each.value, "receive_wait_time_seconds", null)
  redrive_allow_policy              = lookup(each.value, "redrive_allow_policy", null)
  redrive_policy                    = lookup(each.value, "redrive_policy", null)
  sqs_managed_sse_enabled           = lookup(each.value, "sqs_managed_sse_enabled", null)
  visibility_timeout_seconds        = lookup(each.value, "visibility_timeout_seconds", null)

  timeouts = lookup(each.value, "timeouts", null)

  tags = lookup(each.value, "tags", null)
}

module "queue_policy" {
  source = "../resources/queue_policy"

  for_each = var.queue_policies

  region    = try(each.value.region, null) != null ? each.value.region : each.value.queue_url == null ? var.queues[each.value.queue_custom_name].region : null
  policy    = each.value.policy
  queue_url = try(each.value.queue_url, null) != null ? each.value.queue_url : module.queue[each.value.queue_custom_name].url
}

module "redrive_allow_policy" {
  source = "../resources/queue_redrive_allow_policy"

  for_each = var.redrive_allow_policies

  region    = try(each.value.region, null) != null ? each.value.region : each.value.queue_url == null ? var.queues[each.value.queue_custom_name].region : null
  queue_url = try(each.value.queue_url, null) != null ? each.value.queue_url : module.queue[each.value.queue_custom_name].url
  redrive_allow_policy = try(each.value.redrive_allow_policy, null) != null ? each.value.redrive_allow_policy : jsonencode(merge(
    { redrivePermission = each.value.redrive_permission },
    each.value.redrive_permission == "byQueue" ? { sourceQueueArns = try(each.value.source_queue_arns, null) != null ? each.value.source_queue_arns : [for queue in each.value.source_queue_custom_names : module.queue[queue].arn] } : {}
  ))
}

module "redrive_policy" {
  source = "../resources/queue_redrive_policy"

  for_each = var.redrive_policies

  region    = try(each.value.region, null) != null ? each.value.region : each.value.queue_url == null ? var.queues[each.value.queue_custom_name].region : null
  queue_url = try(each.value.queue_url, null) != null ? each.value.queue_url : module.queue[each.value.queue_custom_name].url
  redrive_policy = try(each.value.redrive_policy, null) != null ? each.value.redrive_policy : jsonencode({
    deadLetterTargetArn = try(each.value.dead_letter_target_arn, null) != null ? each.value.dead_letter_target_arn : module.queue[each.value.dead_letter_target_custom_name].arn
    maxReceiveCount     = each.value.max_receive_count
  })
}
