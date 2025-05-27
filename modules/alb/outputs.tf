output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.blue.arn
  
}
output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.app.dns_name
  
}
output "target_green_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.green.arn
  
}
output "lb_listener_arn" {
  description = "The ARN of the ALB listener"
  value       = aws_lb_listener.app.arn
  
}