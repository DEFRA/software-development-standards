provider "aws" {
  region = var.aws_region
}

module "ecs" {
    source                              = "./modules/ecs"
    deployment_prefix                   = var.deployment_prefix
    container_image                     = var.ecs_container_image
    container_cpu_units                 = var.ecs_container_cpu_units
    container_memory                    = var.ecs_container_memory
    tags                                = var.tags
}

module "notify" {
    source                              = "./modules/notify"
    deployment_prefix                   = var.deployment_prefix
    tags                                = var.tags
}

module "scheduler" {
    source                              = "./modules/scheduler"
    deployment_prefix                   = var.deployment_prefix
    cw_events_schedule                  = var.cw_events_schedule
    cw_events_enabled                   = var.cw_events_enabled
    sfn_job_cluster_arn                 = module.ecs.ecs_cluster_arn
    sfn_job_task_definition_arn         = module.ecs.ecs_task_definition_arn
    sfn_task_execution_iam_role_arn     = module.ecs.ecs_task_execution_iam_role_arn
    sfn_failure_sns_topic_arn           = module.notify.sns_topic_arn
    sfn_job_assign_public_ip            = var.sfn_job_assign_public_ip
    sfn_job_subnets                     = var.sfn_job_subnets
    sfn_job_security_groups             = var.sfn_job_security_groups
    sfn_timeout                         = var.sfn_timeout
    sfn_job_max_attempts                = var.sfn_job_max_attempts
    sfn_job_retry_interval              = var.sfn_job_retry_interval
    sfn_job_backoff_rate                = var.sfn_job_backoff_rate
    tags                                = var.tags
}