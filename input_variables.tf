variable "instance_type_for_ec2_in_ecs_cluster" {
  default = "t4g.nano"
  type    = string
}

variable "ami_id_for_ec2_in_ecs_cluster" {
  default = "ami-09ed245c9581057bd" # /aws/service/ecs/optimized-ami/amazon-linux-2/arm64/recommended/image_id
  type    = string
}