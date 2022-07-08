ecs_cluster_size = {
  min = 3
  max = 4
}

# no lifecycle policy in higher environments, we want to preserve older artifacts that have ever been deployed
artifacts_lifecycle_policy = <<EOF
{
  "rules" : [
    {
      "rulePriority" : 1,
      "description" : "Delete old artifacts in higher environments",
      "selection" : {
        "tagStatus" : "any",
        "countType" : "imageCountMoreThan",
        "countNumber" : 3
      },
      "action" : {
        "type" : "expire"
      }
    }
  ]
}
EOF
