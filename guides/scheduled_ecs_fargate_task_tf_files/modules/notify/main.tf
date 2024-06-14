###########################################################################
# SNS Topic
###########################################################################
resource "aws_sns_topic" "notification" {
  name                      = "${var.deployment_prefix}ScheduledTaskFailureNotification"
  tags                      = var.tags
}