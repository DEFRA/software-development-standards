variable "deployment_prefix" {
  type = string
  description = "The prefix identifier used when defining resource names"
}

variable "cw_events_schedule" {
  type = string
  description = "The cloudwatch events schedule expression as defined in https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
}

variable "cw_events_enabled" {
  type = bool
  description = "Enable or disable the cloudwatch event source"
  default = true
}

variable "sfn_job_cluster_arn" {
  type = string
  description = "The ARN of the ECS Fargate cluster where the scheduled tasks shall be executed"
}

variable "sfn_job_task_definition_arn" {
  type = string
  description = "The ARN of the task definition to be executed by the step function"
}

variable "sfn_task_execution_iam_role_arn" {
  type = string
  description = "The ARN of the IAM role used to execute the task on the Fargate cluster"
}

variable "sfn_job_assign_public_ip" {
  type = bool
  description = "Should a public IP be assigned to the task that is executed"
}

variable "sfn_failure_sns_topic_arn" {
  type = string
  description = "The ARN of the SNS topic to notify when an execution failure occurs"
}

variable "sfn_job_subnets" {
  type = list(string)
  description = "The list of subnets in which the task can execute"
}

variable "sfn_job_security_groups" {
  type = list(string)
  description = "The security groups to associated with the executed task"
}

variable "sfn_timeout" {
  type = number
  description = "The timeout for the ECS Task in seconds.  If the task execution exceeds this timeout it shall be terminated"
}

variable "sfn_job_max_attempts" {
  type = number
  description = "The maximum number of time a failed task shall be retried before failing permanently"
  default = 3
}

variable "sfn_job_retry_interval" {
  type = number
  description = "The interval in seconds before retrying the execution of a failed task"
  default = 30
}

variable "sfn_job_backoff_rate" {
  type = number
  description = "The multiplier by which the retry interval increases during each attempt (2.0 by default)"
  default = 2.0
}

variable "tags" {
  type = map(string)
  default = {}
}