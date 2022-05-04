locals {
  ecr_artifacts_repos = [
    {
      ecr_repo_name = "smalldomains.domain-manager"
      project       = "smalldomains"
      application   = "domain-manager"
    }
  ]
}