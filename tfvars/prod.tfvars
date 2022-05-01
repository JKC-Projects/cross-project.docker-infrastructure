ecs_cluster_size = {
  min = 2
  max = 3
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
        "countType" : "sinceImagePushed",
        "countUnit" : "days",
        "countNumber" : 100
      },
      "action" : {
        "type" : "expire"
      }
    }
  ]
}
EOF
