data "aws_region" "current" {}
data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  state_machine_name        = "${var.deployment_prefix}StepFunction"
  event_rule_name           = "${var.deployment_prefix}Schedule"
  task_family_arn           = replace(var.sfn_job_task_definition_arn, "/:\\d+$/", "")       
}

###########################################################################
# Step Function
###########################################################################
resource "aws_sfn_state_machine" "sfn_state_machine" {
  name                      = local.state_machine_name
  depends_on                = [ null_resource.delay ]
  role_arn                  = aws_iam_role.sfn_execution_role.arn
  definition                = templatefile("${path.module}/files/sfn_scheduled_fargate_task.json.tmpl", {
    cluster_arn             = var.sfn_job_cluster_arn
    task_definition_arn     = local.task_family_arn
    assign_public_ip        = var.sfn_job_assign_public_ip ? "ENABLED" : "DISABLED"
    failure_sns_topic_arn   = var.sfn_failure_sns_topic_arn
    subnets                 = var.sfn_job_subnets
    security_groups         = var.sfn_job_security_groups
    timeout                 = var.sfn_timeout
    max_attempts            = var.sfn_job_max_attempts
    retry_interval          = var.sfn_job_retry_interval
    backoff_rate            = var.sfn_job_backoff_rate
  })
  tags                      = var.tags
}

# there is a bug in terraform (https://github.com/terraform-providers/terraform-provider-aws/issues/7893) which is close to being fixed: https://github.com/terraform-providers/terraform-provider-aws/pull/12005
# this is a workaround....
resource "null_resource" "delay" {
 provisioner "local-exec" {
   command                  = "sleep 15"
 }
 depends_on                 = [ aws_iam_role.sfn_execution_role, aws_iam_role_policy.sfn_execution_policy ]
 triggers = {
   "states_exec_role"       = "${aws_iam_role.sfn_execution_role.arn}"
 }
}

###########################################################################
# Step Function IAM Roles
###########################################################################
data "aws_iam_policy_document" "sfn_role_policy" {
  statement {
    effect                  = "Allow"
    principals {
      type                  = "Service"
      identifiers           = ["states.amazonaws.com"]
    }
    actions                 = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "sfn_execution_policy" {
  statement {
    effect                  = "Allow"
    actions                 = [ "events:PutTargets", "events:PutRule", "events:DescribeRule" ]
    resources               = [ 
      "arn:${data.aws_partition.current.partition}:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:rule/StepFunctionsGetEventsForECSTaskRule"
    ]
  }
  statement {
    effect                  = "Allow"
    actions                 = ["iam:PassRole", "iam:GetRole"]
    resources               = [ var.sfn_task_execution_iam_role_arn ]
  }
  statement {
    effect                  = "Allow"
    actions                 = [ "ecs:RunTask" ]
    resources               = [ local.task_family_arn ]
  }
  statement {
    effect                  = "Allow"
    actions                 = [ "ecs:StopTask", "ecs:DescribeTasks" ]
    resources               = [ "*" ]
    condition {
      test                  = "ArnEquals"
      variable              = "ecs:cluster"
      values                = [ var.sfn_job_cluster_arn ]
    }
  }
  statement {
    effect                  = "Allow"
    actions                 = [ "sns:Publish" ]
    resources               = [ var.sfn_failure_sns_topic_arn ]
  }
}

resource "aws_iam_role" "sfn_execution_role" {
  name                      = "${var.deployment_prefix}SfnExecutionRole"
  assume_role_policy        = data.aws_iam_policy_document.sfn_role_policy.json
  tags                      = var.tags
}

resource "aws_iam_role_policy" "sfn_execution_policy" {
  name                      = "${var.deployment_prefix}SfnExecutionRolePolicy"
  role                      = aws_iam_role.sfn_execution_role.id
  policy                    = data.aws_iam_policy_document.sfn_execution_policy.json
}

###########################################################################
# Cloudwatch events
###########################################################################
resource "aws_cloudwatch_event_rule" "schedule" {
  name                      = local.event_rule_name
  description               = "Schedule to execute ${local.state_machine_name}"
  schedule_expression       = var.cw_events_schedule
  is_enabled                = var.cw_events_enabled
  tags                      = var.tags
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule                      = local.event_rule_name
  target_id                 = local.event_rule_name
  role_arn                  = aws_iam_role.cw_events_role.arn
  arn                       = aws_sfn_state_machine.sfn_state_machine.id
  depends_on                = [ aws_cloudwatch_event_rule.schedule ]
}

###########################################################################
# Cloudwatch events IAM rules
###########################################################################
data "aws_iam_policy_document" "cw_events_role_policy" {
  statement {
    effect                  = "Allow"
    principals {
      type                  = "Service"
      identifiers           = ["events.amazonaws.com"]
    }
    actions                 = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "cw_events_execution_policy" {
  statement {
    effect                  = "Allow"
    actions                 = [ "states:StartExecution" ]
    resources               = [ aws_sfn_state_machine.sfn_state_machine.id ]
  }
}

resource "aws_iam_role" "cw_events_role" {
  name                      = "${var.deployment_prefix}CloudWatchEventsRole"
  assume_role_policy        = data.aws_iam_policy_document.cw_events_role_policy.json
  tags                      = var.tags
}

resource "aws_iam_role_policy" "cw_events_role_policy" {
  name                      = "${var.deployment_prefix}CloudwatchEventsRolePolicy"
  role                      = aws_iam_role.cw_events_role.id
  policy                    = data.aws_iam_policy_document.cw_events_execution_policy.json
}
