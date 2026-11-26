module "sqs" {
  source = "./module"

  for_each = var.sqs_map

  queues                 = lookup(each.value, "queues", {})
  queue_policies         = lookup(each.value, "queue_policies", {})
  redrive_allow_policies = lookup(each.value, "redrive_allow_policies", {})
  redrive_policies       = lookup(each.value, "redrive_policies", {})
}
