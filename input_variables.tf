variable "instance_type_for_ec2_in_ecs_cluster" {
  default = "t4g.nano"
  type    = string
}

variable "ami_id_for_ec2_in_ecs_cluster" {
  default = "ami-02e875830ca47abb5" # Amazon Linux 2 (Kernel 5.10) (arm64)
  type    = string
}