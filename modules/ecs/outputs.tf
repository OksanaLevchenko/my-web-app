output "ecs_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.main.id

}

output "ecs_security_group_id" {
  description = "The ID of the ECS security group"
  value       = aws_security_group.ecs_sg.id    

}