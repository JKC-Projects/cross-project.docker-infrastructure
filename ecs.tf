resource "aws_ecs_cluster" "ec2_cluster" {
  name = "ec2-cluster"
  tags = local.common_tags
}

resource "aws_ecs_cluster_capacity_providers" "aws_ecs_cluster_capacity_providers" {
  cluster_name       = aws_ecs_cluster.ec2_cluster.name
  capacity_providers = [aws_ecs_capacity_provider.ec2.name]
}

resource "aws_ecs_capacity_provider" "ec2" {
  name = format("%s_ec2-capacity-provider", aws_ecs_cluster.ec2_cluster)

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ecs_ec2_asg.arn
  }

  tags = local.common_tags
}