ecs_cluster_size = {
  min = 2
  max = 2
}

artifacts_lifecycle_policy = <<EOF
{
  "rules" : [
    {
      "rulePriority" : 1,
      "description" : "Delete old artifacts in DEV environment",
      "selection" : {
        "tagStatus" : "any",
        "countType" : "imageCountMoreThan",
        "countNumber" : 2
      },
      "action" : {
        "type" : "expire"
      }
    }
  ]
}
EOF
