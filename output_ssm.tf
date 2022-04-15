resource "aws_ssm_parameter" "public_subnet_ids" {
  name        = "/ecr/deployment-artifacts"
  type        = "String"
  value       = aws_ecr_repository.artifacts_ecr.repository_url
  description = "The URL of the ECR Deployment Artifacts repository where you can push/pull Docker images"
}