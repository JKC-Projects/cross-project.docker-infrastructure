data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/vpc/public_subnets"
}

data "aws_ssm_parameter" "common_load_balancer_sg" {
  name = "/sg/common-load-balancer"
}