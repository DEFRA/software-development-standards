###########################################################################
# ECS Cluster
###########################################################################
resource "aws_ecs_cluster" "ecs_cluster" {
  name                      = "${var.deployment_prefix}Cluster"
  tags                      = var.tags
}

###########################################################################
# ECS Task Definition
###########################################################################
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                    = "${var.deployment_prefix}TaskDefinition"
  container_definitions     = jsonencode([
    {
      name                  = "${var.deployment_prefix}Job"
      image                 = var.container_image
      cpu                   = var.container_cpu_units
      memory                = var.container_memory
    }
  ])
  execution_role_arn        = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities  = ["FARGATE"]
  cpu                       = var.container_cpu_units
  memory                    = var.container_memory
  network_mode              = "awsvpc"
  tags                      = var.tags
}

###########################################################################
# ECS Task Execution IAM Role
###########################################################################

data "aws_iam_policy_document" "ecs_task_execution_policy" {
  statement {
    effect                  = "Allow"
    principals {
      type                  = "Service"
      identifiers           = ["ecs-tasks.amazonaws.com"]
    }
    actions                 = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name                      = "${var.deployment_prefix}EcsTaskExecutionRole"
  assume_role_policy        =  data.aws_iam_policy_document.ecs_task_execution_policy.json
  tags                      = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attach" {
  role                      = aws_iam_role.ecs_task_execution_role.name
  policy_arn                = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}