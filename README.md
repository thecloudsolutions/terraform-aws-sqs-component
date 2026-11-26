<!-- markdownlint-disable -->
[![Release](https://img.shields.io/github/v/release/thecloudsolutions/terraform-aws-sqs-component?style=for-the-badge&color=6150E8)](https://github.com/thecloudsolutions/terraform-aws-sqs-component/releases)
[![Commit](https://img.shields.io/github/last-commit/thecloudsolutions/terraform-aws-sqs-component?style=for-the-badge&color=FF9800)](https://github.com/thecloudsolutions/terraform-aws-sqs-component/commits)
[![Issues](https://img.shields.io/github/issues/thecloudsolutions/terraform-aws-sqs-component?style=for-the-badge&color=BB019E)](https://github.com/thecloudsolutions/terraform-aws-sqs-component/issues)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-009FD2?style=for-the-badge)](#requirements)
[![License](https://img.shields.io/github/license/thecloudsolutions/terraform-aws-sqs-component?style=for-the-badge&color=3FB950)](https://github.com/thecloudsolutions/terraform-aws-sqs-component/blob/main/LICENSE)

# terraform-aws-sqs-component

[![Cloud Solutions Banner][banner]](https://thecloudsolutions.com/)

[![Sponsor Us](https://img.shields.io/badge/sponsor_us-FF9800?style=for-the-badge)](https://github.com/sponsors/thecloudsolutions)
[![Hire Us](https://img.shields.io/badge/hire_us-009FD2?style=for-the-badge)](https://thecloudsolutions.com/contact-us)
[![Maintained By](https://img.shields.io/badge/maintained_by-Cloud_Solutions-6150E8?style=for-the-badge)](https://thecloudsolutions.com/)

## Description

Terraform component that creates and manages Amazon SQS standard and FIFO queues, access policies, and dead-letter queues. Supports configurable redrive policies and permissions, message retention, delivery delay, visibility timeouts, and server-side encryption.

## Variable Naming

In all Cloud Solutions **components** and **modules**, we intentionally use the _map suffix for input variables that accept map(object(...)).

For example:
```hcl
variable "sqs_map" {
  type        = map(object({ ... }))
  description = "Keyed collection of sqs definitions"
}
```
⚠️ This is a deliberate deviation from [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/syntax/style).

We fully acknowledge that this naming convention does not follow the Terraform style guide, which recommends naming variables based on what they represent, not how they're implemented. We understand this, and want to emphasize:

1. This is a deliberate, informed decision, not an oversight.
2. Our primary goal is clarity and consistency for developers using our modules.
3. The intent is to give users immediate understanding of what kind of structure they're supplying.

### ✅ Why we made this decision (for our components and modules only)

This convention exists only within our components and modules structure. Here's why it works well for us:

1. Instant clarity for users - The _map suffix immediately signals that the variable supports multiple instances, each keyed by name. This avoids confusion around whether a variable is singular or plural.
2. Uniformity across all resources - Instead of struggling with awkward plurals (like kmses, rdses, vpcs, cloudfronts, account_managements) or inconsistent suffixes (_configs, _definitions, etc.), we use one simple, predictable pattern.
3. Avoids naming collisions - The _map suffix never conflicts with native Terraform or AWS resource types.
4. Future-proof for contributors - When contributors see _map, they can safely assume the structure is a map(object(...)) without checking variables.tf.

### 🙌 What this means for contributors

If you're contributing to Cloud Solutions components or modules, please:

1. Use the _map suffix when introducing a new map(object(...)) variable.
2. Follow the naming pattern consistently: rds_map, vpc_map, cloudfront_map, etc.
3. Don't apply this convention to Terraform projects outside components or modules - it's a local convention, not a global best practice.

If you have strong opinions or ideas for evolving this standard, you're welcome to open a discussion.

## Usage

```hcl
module "terraform-aws-sqs-component" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-sqs-component.git"
  # Cloud Solutions recommends to pin every module to a specific version
  # ?ref=x.x.x

  # Required variables
  sqs_map = {
    key = <value>
  }
}
```

> [!IMPORTANT]
> In our examples we don't pin modules to specific versions to keep the documentation aligned with the latest releases.
> However, for your own projects, we recommend to pin each module to the exact version you're using. This approach helps maintain the stability of your infrastructure.
> Additionally, adopting a structured process for version updates will help prevent unexpected changes.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.15.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.60.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sqs"></a> [sqs](#module\_sqs) | ./module | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sqs_map"></a> [sqs\_map](#input\_sqs\_map) | Keyed collection of sqs definitions | <pre>map(object({<br/>    queues = optional(map(object({<br/>      region                            = optional(string)<br/>      content_based_deduplication       = optional(bool)<br/>      deduplication_scope               = optional(string)<br/>      delay_seconds                     = optional(number)<br/>      fifo_queue                        = optional(bool)<br/>      fifo_throughput_limit             = optional(string)<br/>      kms_data_key_reuse_period_seconds = optional(number)<br/>      kms_master_key_id                 = optional(string)<br/>      max_message_size                  = optional(number)<br/>      message_retention_seconds         = optional(number)<br/>      name                              = optional(string)<br/>      name_prefix                       = optional(string)<br/>      policy                            = optional(string)<br/>      # (Optional) Inline policy. Do not combine with queue_policies targeting this queue.<br/>      receive_wait_time_seconds = optional(number)<br/>      redrive_allow_policy      = optional(string)<br/>      # (Optional) Inline redrive allow policy. Do not combine with redrive_allow_policies targeting this queue.<br/>      redrive_policy = optional(string)<br/>      # (Optional) Inline redrive policy. Do not combine with redrive_policies targeting this queue.<br/>      sqs_managed_sse_enabled    = optional(bool)<br/>      visibility_timeout_seconds = optional(number)<br/><br/>      timeouts = optional(object({<br/>        create = optional(string)<br/>        update = optional(string)<br/>        delete = optional(string)<br/>      }))<br/><br/>      tags = optional(map(string))<br/>    })), {})<br/><br/>    queue_policies = optional(map(object({<br/>      region = optional(string)<br/>      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.<br/>      policy    = string<br/>      queue_url = optional(string)<br/>      # (Optional) Queue URL. Takes precedence over queue_custom_name.<br/>      queue_custom_name = optional(string)<br/>      # (Optional) Key in queues within this sqs_map entry. Required when queue_url is omitted.<br/>    })), {})<br/><br/>    redrive_allow_policies = optional(map(object({<br/>      region = optional(string)<br/>      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.<br/>      queue_url = optional(string)<br/>      # (Optional) Queue URL. Takes precedence over queue_custom_name.<br/>      queue_custom_name = optional(string)<br/>      # (Optional) Key in queues within this sqs_map entry. Required when queue_url is omitted.<br/>      redrive_allow_policy = optional(string)<br/>      # (Optional) JSON policy. Takes precedence over the structured policy fields.<br/>      redrive_permission = optional(string)<br/>      # (Optional) Required when redrive_allow_policy is omitted. Valid values are allowAll, denyAll and byQueue.<br/>      source_queue_arns = optional(set(string))<br/>      # (Optional) Source queue ARNs for byQueue. Takes precedence over source_queue_custom_names.<br/>      source_queue_custom_names = optional(set(string), [])<br/>      # (Optional) Source queue keys in queues within this sqs_map entry for byQueue when source_queue_arns is omitted.<br/>    })), {})<br/><br/>    redrive_policies = optional(map(object({<br/>      region = optional(string)<br/>      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.<br/>      queue_url = optional(string)<br/>      # (Optional) Source queue URL. Takes precedence over queue_custom_name.<br/>      queue_custom_name = optional(string)<br/>      # (Optional) Source queue key in queues within this sqs_map entry. Required when queue_url is omitted.<br/>      redrive_policy = optional(string)<br/>      # (Optional) JSON policy. Takes precedence over the structured policy fields.<br/>      dead_letter_target_arn = optional(string)<br/>      # (Optional) Destination queue ARN. Takes precedence over dead_letter_target_custom_name.<br/>      dead_letter_target_custom_name = optional(string)<br/>      # (Optional) Destination queue key in queues within this sqs_map entry. Required when redrive_policy and dead_letter_target_arn are omitted.<br/>      max_receive_count = optional(number)<br/>      # (Optional) Required when redrive_policy is omitted. Number of receives before moving a message to the destination queue.<br/>    })), {})<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sqs_queue_arns"></a> [sqs\_queue\_arns](#output\_sqs\_queue\_arns) | ARNs of the SQS queues, keyed by SQS definition and queue. |
| <a name="output_sqs_queue_ids"></a> [sqs\_queue\_ids](#output\_sqs\_queue\_ids) | URLs of the SQS queues, keyed by SQS definition and queue. |
| <a name="output_sqs_queue_urls"></a> [sqs\_queue\_urls](#output\_sqs\_queue\_urls) | URLs of the SQS queues, keyed by SQS definition and queue. |
| <a name="output_sqs_queue_tags_all"></a> [sqs\_queue\_tags\_all](#output\_sqs\_queue\_tags\_all) | Tags assigned to the queues, including provider default tags, keyed by SQS definition and queue. |
| <a name="output_sqs_queue_names"></a> [sqs\_queue\_names](#output\_sqs\_queue\_names) | Names of the SQS queues, keyed by SQS definition and queue. |

## Quick Start

The project is under active development, and we welcome all contributors! 🎉
  
Before you start, please review our [Contributor Guidelines](https://github.com/thecloudsolutions/.github/blob/main/CONTRIBUTING.md) to understand the expectations and processes.
  
Follow these steps to get started:
  
---
  
### 1. **Fork the Repository**
- Click the **"Fork"** button on the repository's GitHub page to create a copy under your GitHub account.

> [!TIP]
> If you're new to GitHub, check out the [GitHub Docs](https://docs.github.com/en/get-started) to familiarize yourself with key concepts like forking, branching, and pull requests.
  
### 2. **Clone the Fork**
- Clone your fork to your local machine using:
  ```bash
  git clone https://github.com/<your-username>/<repository-name>.git
  ```
  
### 3. **Create a Branch**
- Create a new branch for your contribution:
  ```bash
  git checkout -b your-feature-name
  ```
  
### 4. **Make Changes**
- Implement your changes in the codebase.
- Ensure you follow the project's style guide and standards.
  
> [!WARNING]
> Always adhere to the project's coding standards and best practices outlined in the [CONTRIBUTING.md](https://github.com/thecloudsolutions/.github/blob/main/CONTRIBUTING.md) file.
    
### 5. **Test Your Changes**
- Run tests to verify your changes locally.
- Follow any project-specific testing instructions.
    
### 6. **Commit Your Changes**
- Stage and commit your changes with a clear and concise message:
  ```bash
  git add .
  git commit -m "Add description of the change"
  ```

> [!NOTE]
> Use meaningful commit messages in the present tense (e.g., "Add feature X" instead of "Added feature X").
  
### 7. **Push Your Branch**
- Push your branch to your fork:
  ```bash
  git push origin your-feature-name
  ```
    
### 8. **Open a Pull Request (PR)**
- Navigate to the original repository and click the **"New Pull Request"** button.
- Select your branch and submit your PR following the [Pull Request template](https://github.com/thecloudsolutions/.github/blob/main/.github/PULL_REQUEST_TEMPLATE/pull_request_template.md).
- Use keywords like `Closes #123` to link your PR to a related issue.
  
### **🎉 Congratulations, you’ve made your first contribution! 🎉**  
We appreciate your effort and look forward to reviewing your work.

## About Us

**Cloud Solutions: Innovating Open Source for AWS & DevOps**

Cloud Solutions creates and maintains free, open-source tools to help startups thrive in the AWS Cloud and DevOps space. Our mission is to make advanced technology accessible to businesses of all sizes.

With years of experience and a commitment to innovation, we design solutions that simplify workflows, encourage collaboration, and drive growth - removing cost barriers along the way. Every contribution brings us closer to a future where technology empowers all.

Your support makes everything we do possible.

Thank you for being part of our journey to empower innovation and build a stronger Open Source future!

## Contributing

The project is under active development, and we welcome all contributors! 🎉 

Before you start, please review our [Contributor Guidelines](CONTRIBUTING.md) to understand the expectations and processes.

## Blog

Link to our [blog](https://thecloudsolutions.com/blog), where you can explore in-depth articles. Gain valuable insights and expert analysis on AWS cloud solution strategies and trends.

## License

The project is 100% Open Source and licensed under the [APACHE2](LICENSE).

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## Copyrights

Copyright © 2020-2026 [Cloud Solutions](https://thecloudsolutions.com)

[banner]: https://github.com/thecloudsolutions/.github/blob/main/profile/banner.png