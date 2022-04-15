resource "aws_ssm_parameter" "ecs_deployment_artifacts_url" {
  name        = "/ecr/deployment-artifacts"
  type        = "String"
  value       = aws_ecr_repository.artifacts_ecr.repository_url
  description = "The URL of the ECR Deployment Artifacts repository where you can push/pull Docker images"
}

resource "aws_ssm_parameter" "ecs_ec2_cluster" {
  name        = "/ecs/ec2-cluster"
  type        = "String"
  value       = aws_ecs_cluster.ec2_cluster.name
  description = "The name of the ECS cluster (${aws_ecs_cluster.ec2_cluster.name}) used to deploy Docker containers"
}