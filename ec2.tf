resource "aws_autoscaling_group" "ecs_ec2_asg" {
  name                = "asg_for_ec2_ecs"
  min_size            = 1
  max_size            = 1
  vpc_zone_identifier = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  launch_template {
    id      = aws_launch_template.for_ecs_ec2_asg.id
    version = "$Latest"
  }

  # The ASG used for our ECS-on-EC2 Cluster needs to have
  # the "AmazonECSManaged" tag lest there be issues with scaling-in
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_capacity_provider
  tag {
    key                 = "AmazonECSManaged"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "composing_ecs_cluster"
    value               = aws_ecs_cluster.ec2_cluster.name
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_launch_template" "for_ecs_ec2_asg" {
  name          = "ec2_ecs_cluster_launch_template"
  instance_type = var.instance_type_for_ec2_in_ecs_cluster
  image_id      = var.ami_id_for_ec2_in_ecs_cluster
  description = format("The launch template for creating the EC2 instances used to form the ECS cluster %s",
  aws_ecs_cluster.ec2_cluster.name)

  tags = local.common_tags
}