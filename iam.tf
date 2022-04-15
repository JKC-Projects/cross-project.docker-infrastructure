resource "aws_iam_role" "ecs_instance_role" {
  name = "ecsInstanceRole"
  description = "An IAM Role allowing ECS Container Agents to communicate with our ECS Service"

  managed_policy_arns = [
    # An AWS-Managed Policy designed that gives necessary authorisations to the ECS Container Agent
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]

  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role" "write_access_ecr_artifacts" {
  name        = "WriteAccessECRArtifacts"
  description = "Grants write-access to the ECR Artifacts Repository"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          "AWS" : data.aws_caller_identity.current.account_id # TODO harden security 
        }
      },
    ]
  })
}