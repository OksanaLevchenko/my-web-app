output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id

}
output "public_subnet_ids" {
description = "List of public subnet IDs"
value = [for subnet in values(aws_subnet.public) : subnet.id]
}

output "private_subnet_ids" {
description = "List of private subnet IDs"
value = [for subnet in values(aws_subnet.private) : subnet.id]
}