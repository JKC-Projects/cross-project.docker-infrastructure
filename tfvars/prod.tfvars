ecs_cluster_size = {
  min = 2
  max = 3
}

# no lifecycle policy in higher environments, we want to preserve all artifacts that have ever been deployed
artifacts_lifecycle_policy = <<EOF
{
  "rules" : []
}
EOF