output "this_ecs_cluster_id" {
  value = aws_ecs_cluster.this.*.id
}

output "this_ecs_cluster_arn" {
  value = aws_ecs_cluster.this.*.arn
}

output "this_ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = var.name
}