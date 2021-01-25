###########################################################################
# ECS Task Execution IAM Role
###########################################################################
output "ecs_cluster_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = aws_ecs_cluster.ecs_cluster.arn
}

###########################################################################
# ECS Task Definition
###########################################################################
output "ecs_task_definition_arn" {
  description = "Full ARN of the Task Definition (including both family and revision)."
  value       = aws_ecs_task_definition.ecs_task_definition.arn
}

output "ecs_task_definition_family" {
  description = "The family of the Task Definition."
  value       = aws_ecs_task_definition.ecs_task_definition.family
}

output "ecs_task_definition_revision" {
  description = "The revision of the task in a particular family."
  value       = aws_ecs_task_definition.ecs_task_definition.revision
}

output "ecs_task_definition_container_name" {
  description = "The name of the container referenced by the task definition"
  value       = "${var.deployment_prefix}Job"
}

output "ecs_task_definition_container_image" {
  description = "The image of the container referenced by the task definition"
  value       = var.container_image
}

###########################################################################
# ECS Task Execution IAM Role
###########################################################################
output "ecs_task_execution_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = aws_iam_role.ecs_task_execution_role.arn
}