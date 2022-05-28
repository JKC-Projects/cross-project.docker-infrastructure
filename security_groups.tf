resource "aws_security_group" "for_ec2_composing_ecs_cluster" {
  name = "SG_ec2s_in_ecs_cluster"
  description = format("Security Group securing the EC2 instances composing the ECS Cluster %s",
  aws_ecs_cluster.ec2_cluster.name)

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}