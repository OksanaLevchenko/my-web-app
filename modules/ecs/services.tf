resource "aws_ecs_task_definition" "app" {
    family                   = "${var.app_name}-task"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                     = var.cpu
    memory                  = var.memory
    execution_role_arn      = var.ecs_execution_role_arn
    task_role_arn           = var.ecs_task_role_arn
    
    container_definitions = jsonencode([
      
    {
        name = "nginx-container"
        image = "842675975340.dkr.ecr.us-east-1.amazonaws.com/my-app-repository:latest"
        essential = true
        portMappings = [
            {
                containerPort = 80
                hostPort      = 80
                protocol      = "tcp"
            }
        ]
        logConfiguration = {
            logDriver = "awslogs"
            options = {
                awslogs-create-group = "true"
                awslogs-group        = var.log_group_name
                awslogs-region       = var.region
                awslogs-stream-prefix = "nginx"
            }
        }
    }
    ])
  
}

resource "aws_ecs_service" "app" {
    name            = "${var.app_name}-service"
    cluster         = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.app.arn
    desired_count   = var.desired_count
    launch_type     = "FARGATE"
    deployment_controller {
        type = "CODE_DEPLOY"
    }
    
    network_configuration {
        subnets          = var.subnet_ids
        security_groups  = [aws_security_group.ecs_sg.id]
        assign_public_ip = true
    }
    
    load_balancer {
        target_group_arn = var.lb_target_group_arn
        container_name   = "nginx-container"
        container_port   = 80
    }
    

  
}
resource "aws_appautoscaling_target" "ecs_service_target" {
    max_capacity       = 10
    min_capacity       = 1
    resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.app.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"
  
}

resource "aws_appautoscaling_policy" "cpu_policy" {
    name                   = "cpu-scaling-policy"
    policy_type           = "TargetTrackingScaling"
    resource_id            = aws_appautoscaling_target.ecs_service_target.resource_id
    scalable_dimension     = aws_appautoscaling_target.ecs_service_target.scalable_dimension
    service_namespace      = aws_appautoscaling_target.ecs_service_target.service_namespace
    target_tracking_scaling_policy_configuration {
        target_value       = 50.0
        scale_in_cooldown  = 60
        scale_out_cooldown = 60
        disable_scale_in   = false
       
  
   
  
        predefined_metric_specification {
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
        
        }
    }
  
}

resource "aws_codedeploy_app" "ecs_app" {
    compute_platform = "ECS"
    name             = "${var.app_name}-codedeploy-app"
    tags = {
        Name        = "${var.app_name}-codedeploy-app"
        Environment = var.environment
    }
  
}
resource "aws_codedeploy_deployment_group" "ecs_app" {
    app_name= aws_codedeploy_app.ecs_app.name
    deployment_group_name = "${var.app_name}-deployment-group"
    service_role_arn = var.codedeploy_role_arn
    deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
    deployment_style {
        deployment_type = "BLUE_GREEN"
        deployment_option = "WITH_TRAFFIC_CONTROL"

    }
    blue_green_deployment_config {
        terminate_blue_instances_on_deployment_success {
            action = "TERMINATE"
    
        }
        deployment_ready_option {
            action_on_timeout = "CONTINUE_DEPLOYMENT"
        
        }
    }
    ecs_service {
        cluster_name = aws_ecs_cluster.main.name
        service_name = aws_ecs_service.app.name
        
    }
    load_balancer_info {
        target_group_pair_info {
            target_group {
              name = var.lb_target_group_arn

            }
            target_group {
              name = var.lb_green_target_group_arn

            }
            prod_traffic_route {
                listener_arns = [var.lb_listener_arn]
            }
        }
    }
}
