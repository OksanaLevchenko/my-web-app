resource "aws_cloudwatch_log_group" "ecs_app" {
    name = "${var.app_name}-log-group"
    retention_in_days = 7
    tags = {
        Name        = "${var.app_name}-log-group"
        Environment = var.environment
    }
  
}