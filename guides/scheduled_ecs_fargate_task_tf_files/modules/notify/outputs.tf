###########################################################################
# SNS Topic
###########################################################################
output "sns_topic_arn" {
  description = "The ARN of the SNS topic to which failures should be pushed."
  value       = aws_sns_topic.notification.arn
}