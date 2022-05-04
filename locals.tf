locals {
  applications = [
    {
      project     = "smalldomains"
      application = "domain-manager"
    }
  ]

  ecr_artifacts_repos = [for a in local.application : "${a.project}.${a.application}"]
}