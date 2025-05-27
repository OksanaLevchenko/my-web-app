resource "aws_ecr_repository" "services" {
    name = "${var.app_name}-repository"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
  
}