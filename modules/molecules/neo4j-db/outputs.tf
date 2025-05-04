# output the public IP address of the instance
output "public_ip" {
  description = "The public IP address of the instance"
  value       = google_compute_instance.neo4j.network_interface[0].access_config[0].nat_ip
}

# output the private IP address of the instance
output "private_ip" {
  description = "The private IP address of the instance"
  value       = google_compute_instance.neo4j.network_interface[0].network_ip
}

