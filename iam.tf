resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "ecsInstanceRole"
  role = aws_iam_role.iam_role_for_ecs_instance_role.name
}

resource "aws_iam_role" "iam_role_for_ecs_instance_role" {
  name        = "RoleForECSContainerAgents"
  description = "An IAM Role allowing ECS Container Agents to communicate with our ECS Service"

  managed_policy_arns = [
    # An AWS-Managed Policy designed that gives necessary authorisations to the ECS Container Agent
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]

  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "ecs.amazonaws.com",
            "ecs-tasks.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}