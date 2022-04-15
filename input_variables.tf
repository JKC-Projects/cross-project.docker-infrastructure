variable "environment" {
  type = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Valid values for var.environment are [\"dev\",\"stage\",\"prod\"]."
  }

  description = "Describes the environment being deployed to. Must be one of either [\"dev\",\"stage\",\"prod\"]"
}

variable "ecs_cluster_size" {
  type = object({
    min = number,
    max = number
  })

  validation {
    condition     = var.ecs_cluster_size.min >= 1 && var.ecs_cluster_size.min <= 10
    error_message = "Minimum size must be between 1 and 10."
  }

  validation {
    condition     = var.ecs_cluster_size.max >= 1 && var.ecs_cluster_size.max <= 10
    error_message = "Maximum size must be between 1 and 10."
  }

  validation {
    condition     = var.ecs_cluster_size.min <= var.ecs_cluster_size.max
    error_message = "Minimum size must be smaller than or equal to maximum size."
  }
}

variable "ec2_spec_for_ecs_cluster" {
  type = object({
    instance_type = string,
    ami_id        = string
  })

  description = "Specifies the EC2 instances used in the ECS cluster (instance type, AMI)"
}

variable "artifacts_lifecycle_policy" {
  type        = string
  description = "The ECR Lifecycle policy used for expiring images stored in the ECR Artifacts Repository"
}