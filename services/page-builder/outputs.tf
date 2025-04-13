output "service_url" {
  value = google_cloud_run_service.page_builder.status[0].url
}

output "topic_id" {
  value = google_pubsub_topic.page_builder_topic.id
}

output "topic_name" {
  value = google_pubsub_topic.page_builder_topic.name
}
