resource "aws_security_group" "for_ec2_composing_ecs_cluster" {
  name = "SG_ec2s_in_ecs_cluster"
  description = format("Security Group securing the EC2 instances composing the ECS Cluster %s",
  aws_ecs_cluster.ec2_cluster.name)

  ingress {
    description     = "Only allow ingress traffic from the load balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [data.aws_ssm_parameter.common_load_balancer_sg.value]
  }

  egress {
    description = "Open ports for communication by the ECS Container Agents"
    from_port   = 51678
    to_port     = 51680
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}