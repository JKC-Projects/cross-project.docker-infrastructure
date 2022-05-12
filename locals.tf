locals {
  applications = [
    {
      project     = "smalldomains"
      application = "domain-manager"
    }
  ]

  # holds meta-info on each of the ECR deployment-artifact repos to be created
  ecr_artifacts_repos = [for a in local.applications :
    {
      ecr_repo_name = "${a.project}.${a.application}"
      project       = a.project
      application   = a.application
    }
  ]
}