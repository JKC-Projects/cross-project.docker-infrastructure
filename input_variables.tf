variable "instance_type_for_ec2_in_ecs_cluster" {
  default = "t4g.nano"
  type    = string
}

variable "ami_id_for_ec2_in_ecs_cluster" {
  default = "ami-0bb7c2ee184bc8249" # /aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id
  type    = string
}