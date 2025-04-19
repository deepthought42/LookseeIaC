output "service_url" {
  value = module.pubsub_event_driven_service.service_url
  description = "The URL of the Cloud Run service"
}