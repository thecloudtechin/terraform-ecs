output "ecs_cluster" {
    value = aws_ecs_cluster.deliveryguru.id
  
}

output "ecs-task" {
    value = aws_ecs_task_definition.deliveryguru-task.container_definitions
  
}
