resource "aws_ecr_repository" "artifacts_ecr" {
  name                 = "deployment-artifacts"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# auto delete old images in the repository
resource "aws_ecr_lifecycle_policy" "ecr_artifacts_lifecycle_policy" {
  repository = aws_ecr_repository.artifacts_ecr.name
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
        "Sid" : "WriteAccessForIAMRoleOnly",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : aws_iam_role.write_access_ecr_artifacts.arn
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