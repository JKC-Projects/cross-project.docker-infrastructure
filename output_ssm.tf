resource "aws_ssm_parameter" "ecs_deployment_artifacts_url" {
  for_each    = { for a in local.ecr_artifacts_repos : a.ecr_repo_name => a }
  name        = format("/ecr/deployment-artifacts/%s/%s", each.value.project, each.value.application)
  type        = "String"
  value       = aws_ecr_repository.artifacts_ecr[each.key].repository_url
  description = format("[%s] The URL of the ECR Deployment Artifacts repository where you can push/pull Docker images", each.key)
}

resource "aws_ssm_parameter" "ecs_ec2_cluster" {
  name        = "/ecs/ec2-cluster"
  type        = "String"
  value       = aws_ecs_cluster.ec2_cluster.name
  description = "The name of the ECS cluster (${aws_ecs_cluster.ec2_cluster.name}) used to deploy Docker containers"
}

resource "aws_ssm_parameter" "ecs_instance_role_arn" {
  name        = "/iam/ecs/ecs-instance-role"
  type        = "String"
  value       = aws_iam_role.iam_role_for_ecs_instance_role.arn
  description = "The ARN of the ecsInstanceRole IAM role used by the ECS Container Agent"
}