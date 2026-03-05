output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "kinesis_stream_arns" {
  value = module.kinesis_streams.stream_arns
}

output "neo4j_private_ip" {
  value = module.neo4j_db.private_ip
}

output "ecs_services" {
  value = {
    api          = module.api_service.service_name
    page_builder = module.page_builder_service.service_name
    audit_manager = module.audit_manager_service.service_name
  }
}
