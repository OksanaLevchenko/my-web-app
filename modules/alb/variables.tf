variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = ""  
  
}
variable "environment" {
  description = "Environment name"
  type        = string
  default     = ""  
  
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""  
  
}
variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
  default     = []      
  
}
variable "ecs_security_group_id" {
  description = "Security group ID for the ECS service"
  type        = string
  default     = ""  
  
}