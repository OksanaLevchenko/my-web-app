variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = ""

}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""

}
variable "environment" {
  description = "Environment name"
  type        = string
  default     = ""

}
variable "lb_target_group_arn" {
  description = "ARN of the load balancer target group"
  type        = string
  default     = ""
  
}
variable "desired_count" {
  description = "Desired number of instances in the ECS service"
  type        = number
  default     = 1
  
}
variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
  default     = []  
  
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1" 
  
}
variable "cpu" {
  description = "CPU units for the ECS task definition"
  type        = string
  default     = "256"   
  
}
variable "memory" {
  description = "Memory for the ECS task definition"
  type        = string
  default     = "512"       
  
}
variable "ecs_execution_role_arn" {
  description = "ARN of the ECS execution role"
  type        = string
  default     = ""  
  
}
variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
  default     = ""      
  
}
variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = ""  
  
}
variable "lb_green_target_group_arn" {
  description = "ARN of the green target group for the load balancer"
  type        = string
  default     = ""  
  
}
variable "lb_listener_arn" {
  description = "ARN of the load balancer listener"
  type        = string
  default     = ""  
  
}
variable "codedeploy_role_arn" {
  description = "ARN of the CodeDeploy role"
  type        = string
  default     = ""  
  
}