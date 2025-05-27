module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  vpc_name    = var.vpc_name
  environment = var.environment

}
module "ecs" {
  depends_on = [ module.vpc, module.iam, module.cloudwatch,module.ecr ]
  source      = "./modules/ecs"
  app_name    = var.app_name
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  ecs_task_role_arn = module.iam.ecs_task_role_arn
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
  subnet_ids = module.vpc.private_subnet_ids
  region = var.aws_region
  lb_target_group_arn = module.alb.target_group_arn
  log_group_name = module.cloudwatch.aws_cloudwatch_log_group_name
  lb_green_target_group_arn = module.alb.target_green_group_arn
  lb_listener_arn = module.alb.lb_listener_arn
  codedeploy_role_arn = module.iam.code_deploy_role_arn
}

module "cloudwatch" {
  source      = "./modules/cloudwatch"
  app_name    = var.app_name
  environment = var.environment
  
}
module "iam" {
  source      = "./modules/iam"
  app_name    = var.app_name
  environment = var.environment
  
}
module "alb" {
  source      = "./modules/alb"
  app_name    = var.app_name
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  ecs_security_group_id =  module.ecs.ecs_security_group_id 
  
}

module "ecr" {
    source      = "./modules/ecr"
    app_name    = var.app_name
    
  
}