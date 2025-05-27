output "ecs_execution_role_arn" {
  description = "The ARN of the ECS execution role"
  value       = aws_iam_role.ecs_task_execution.arn
  
}
output "ecs_task_role_arn" {
  description = "The ARN of the ECS task role"
  value       = aws_iam_role.ecs_task_role.arn
  
}
output "code_deploy_role_arn" {
  description = "The ARN of the CodeDeploy role"
  value       = aws_iam_role.codedeploy.arn
  
}