resource "aws_lb" "app" {
    name               = "${var.app_name}-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [var.ecs_security_group_id]
    subnets            = var.subnet_ids
    
    enable_deletion_protection = false
    
    enable_http2 = true
    
    tags = {
        Name        = var.app_name
        Environment = var.environment
    }
  
}
resource "aws_lb_target_group" "blue" {
    name     = "${var.app_name}-blue-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    target_type = "ip"
    lifecycle {
    create_before_destroy = true
    }
    
    health_check {
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold  = 2
        unhealthy_threshold = 2
        matcher             = "200-299"
    }
    
    tags = {
        Name        = var.app_name
        Environment = var.environment
    }
  
}
resource "aws_lb_listener" "app" {
    load_balancer_arn = aws_lb.app.arn
    port              = 80
    protocol          = "HTTP"
    
    default_action {
        type = "forward"
        
         
            target_group_arn = aws_lb_target_group.blue.arn
            
    }
    
    tags = {
        Name        = var.app_name
        Environment = var.environment
    }
  
}
resource "aws_lb_target_group" "green" {
    name     = "${var.app_name}-green-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    target_type = "ip"
    lifecycle {
    create_before_destroy = true
    }
    health_check {
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold  = 2
        unhealthy_threshold = 2
        matcher             = "200-299"
    }
    
    tags = {
        Name        = var.app_name
        Environment = var.environment
    }
  
}