output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id

}
output "dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name

}
 
output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.ecr_repository_url
  
}