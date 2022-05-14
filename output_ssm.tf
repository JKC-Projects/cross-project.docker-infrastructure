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
  value       = aws_ecs_cluster.ec2_cluster.arn
  description = "The ARN of the ECS cluster used to deploy Docker containers into"
}

resource "aws_ssm_parameter" "iam_role_for_ecs_container_agents" {
  name        = "/iam/ecs/ecs-container-agent-role"
  type        = "String"
  value       = aws_iam_role.iam_role_for_ecs_instance_role.arn
  description = format("The ARN of the IAM role used by the ECS Container Agents (%s)", aws_iam_role.iam_role_for_ecs_instance_role.name)
}