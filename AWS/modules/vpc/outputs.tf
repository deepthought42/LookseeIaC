output "vpc_id" { value = aws_vpc.this.id }
output "private_subnet_ids" { value = aws_subnet.private[*].id }
output "public_subnet_id" { value = aws_subnet.public.id }
output "ecs_cluster_id" { value = aws_ecs_cluster.this.id }
output "ecs_service_security_group_id" { value = aws_security_group.ecs_service.id }
output "neo4j_security_group_id" { value = aws_security_group.neo4j.id }
output "ecs_task_execution_role_arn" { value = aws_iam_role.ecs_task_execution.arn }
output "ecs_task_role_arn" { value = aws_iam_role.ecs_task.arn }
