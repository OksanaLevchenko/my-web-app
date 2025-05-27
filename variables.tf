variable "vpc_cidr" {

  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "vpc_name" {

  description = "Name of the VPC"
  type        = string
  default     = ""

}
variable "environment" {

  description = "Environment name"
  type        = string
  default     = ""
}
variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = ""
  
}
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
  
}