locals {
  applications = [
    {
      project     = "smalldomains"
      application = "domain-manager"
    }
  ]

  # the key to this will be used to name the corresponding deployment-artifacts repo
  ecr_artifacts_repos = [for a in local.applications :
    {
      ecr_repo_name = "${a.project}.${a.application}"
      project       = a.project
      application   = a.application
    }
  ]
}