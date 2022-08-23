ec2_spec_for_ecs_cluster = {
  instance_type = "t4g.small" # arm64
  ami_id        = "ami-009f06b04135aa24e" # ECS-Optimised ECS /aws/service/ecs/optimized-ami/amazon-linux-2/arm64/recommended/image_id arm64
}

##maybe use t3a.micro or t3.micro or t4g.small