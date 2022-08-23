ec2_spec_for_ecs_cluster = {
  instance_type = "t4g.small"
  ami_id        = "ami-044fb3b709f19cb4a" # ECS-Optimised ECS /aws/service/ecs/optimized-ami/amazon-linux-2/recommended/ x86_64
}

##maybe use t3a.micro or t3.micro or t4g.small