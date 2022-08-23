ec2_spec_for_ecs_cluster = {
  instance_type = "t4g.small"
  ami_id        = "ami-07a1802c113adc855" # ECS-Optimised ECS /aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id
}

##maybe use t3a.micro or t3.micro or t4g.small