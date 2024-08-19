resource "aws_iam_role" "ecs" {
  name               = "${var.environment}-${var.ecs_service_name}-ecs-role"
  assume_role_policy = file("${path.module}/files/iam/assume-role-policy-ecs.json")

}

resource "aws_iam_role_policy" "ecs" {
  name = "${var.environment}-${var.ecs_service_name}-ecs-policy"
  role = aws_iam_role.ecs.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

}
