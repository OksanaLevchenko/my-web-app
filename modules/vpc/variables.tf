variable "vpc_cidr" {

  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
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
variable "public_subnet" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "private_subnet" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.14.0/24"]
}