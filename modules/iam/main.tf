resource "aws_iam_role" "ecs_task_execution" {
    name = "${var.app_name}-ecs-task-execution-role"
    assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assemed_role.json
    tags = {
        Name        = "${var.app_name}-ecs-task-execution-role"
        Environment = var.environment
    }
  
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
    role       = aws_iam_role.ecs_task_execution.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  
}

resource "aws_iam_role_policy" "ecs_execution_policy" {
    name   = "${var.app_name}-ecs-execution-policy"
    role   = aws_iam_role.ecs_task_execution.id
    policy = data.aws_iam_policy_document.ecs_execution_policy.json
  
}
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.app_name}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assemed_role.json
}

resource "aws_iam_role" "codedeploy" {
    name = "${var.app_name}-codedeploy-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    Service = "codedeploy.amazonaws.com"
                }
                Action = "sts:AssumeRole"
            }
        ]
    })
  
}

resource "aws_iam_role_policy_attachment" "codedeploy" {
    role       = aws_iam_role.codedeploy.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  
}
resource "aws_iam_policy" "codedeploy_ecs_policy" {
  name = "codedeploy-ecs-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecs:DescribeServices",
          "ecs:UpdateService",
          "ecs:DescribeTaskDefinition"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_ecs_attach" {
  role       = aws_iam_role.codedeploy.name
  policy_arn = aws_iam_policy.codedeploy_ecs_policy.arn
}
