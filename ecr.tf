locals {
  ecr_artifacts_repos = [
    {
      ecr_repo_name = "smalldomains.domain-manager"
      project       = "smalldomains"
      application   = "domain-manager"
    }
  ]
}

resource "aws_ecr_repository" "artifacts_ecr" {
  for_each             = { for a in local.ecr_artifacts_repos : a.ecr_repo_name => a }
  name                 = format("deployment-artifacts/%s", each.key.ecr_repo_name)
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# auto delete old images in the repository
resource "aws_ecr_lifecycle_policy" "ecr_artifacts_lifecycle_policy" {
  for_each   = aws_ecr_repository.artifacts_ecr
  repository = each.value.name
  policy     = var.artifacts_lifecycle_policy
}

resource "aws_ecr_repository_policy" "iam_access_to_ecr_artifacts" {
  repository = aws_ecr_repository.artifacts_ecr.name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ReadAccessForAll",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : data.aws_caller_identity.current.account_id
        }
        "Action" : [
          "ecr:DescribeImageScanFindings",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:GetDownloadUrlForLayer",
          "ecr:DescribeImageReplicationStatus",
          "ecr:ListTagsForResource",
          "ecr:ListImages",
          "ecr:BatchGetRepositoryScanningConfiguration",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
          "ecr:DescribeRepositories",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetRepositoryPolicy",
          "ecr:GetLifecyclePolicy",
          "ecr:GetRegistryPolicy",
          "ecr:DescribeRegistry",
          "ecr:DescribePullThroughCacheRules",
          "ecr:GetAuthorizationToken",
          "ecr:GetRegistryScanningConfiguration"
        ]
      },
      {
        "Sid" : "WriteAccessForAll",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : data.aws_caller_identity.current.account_id
        },
        "Action" : [
          "ecr:PutLifecyclePolicy",
          "ecr:PutImageTagMutability",
          "ecr:StartImageScan",
          "ecr:CreateRepository",
          "ecr:PutImageScanningConfiguration",
          "ecr:UploadLayerPart",
          "ecr:BatchDeleteImage",
          "ecr:PutRegistryScanningConfiguration",
          "ecr:CreatePullThroughCacheRule",
          "ecr:DeletePullThroughCacheRule",
          "ecr:DeleteLifecyclePolicy",
          "ecr:DeleteRepository",
          "ecr:PutImage",
          "ecr:BatchImportUpstreamImage",
          "ecr:UntagResource",
          "ecr:CompleteLayerUpload",
          "ecr:TagResource",
          "ecr:StartLifecyclePolicyPreview",
          "ecr:InitiateLayerUpload",
          "ecr:ReplicateImage",
          "ecr:PutReplicationConfiguration"
        ]
      }
    ]
  })
}