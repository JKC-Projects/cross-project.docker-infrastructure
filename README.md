# docker-infrastructure
Handles the provisioning of docker-related infrastructure across all projects. This includes ECR, ECS clusters and any other resources required to support these.

## Pre-Requsites
Some variables are already pre-set in the tfvars directory. Other must be set:
1. `environment` - Terraform Variable - Must be one of either "dev", "stage" or "prod"