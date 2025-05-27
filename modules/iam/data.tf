data "aws_iam_policy_document" "ecs_task_execution_assemed_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


data "aws_iam_policy_document" "ecs_execution_policy" {
    statement {
        actions = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
            "logs:DescribeLogStreams",
            "logs:DescribeLogGroups",
            "logs:TagResources",
            "logs:UntagResource",
            "logs:DeleteLogGroup"
            ]

        resources = ["*"]
        effect    = "Allow"
    
    }
}