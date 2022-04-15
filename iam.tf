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