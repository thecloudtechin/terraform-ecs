resource "aws_ecs_cluster" "deliveryguru" {
    name = "deliveryguru"

  
}

resource "aws_ecs_task_definition" "deliveryguru-task" {
  family                = aws_ecs_cluster.deliveryguru.name
  
  container_definitions = jsonencode([
    {
      name         = "deliveryguru"
      image        = "arunr039/lumen"
      cpu          = 1
      memory       = 128
      essential    = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }


  ])
}
data "aws_vpc" "available" {
  state = "available"
}

resource "aws_alb" "main" {
  load_balancer_type = "application"
  name = "deliveryguru"
  count = length(data.aws_vpc.available)
  subnets = data.aws_vpc.available[count.index]

}
 


