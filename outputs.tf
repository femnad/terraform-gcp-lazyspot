output "network_name" {
  value = google_compute_network.network.name
}

output "instance_ip_addr" {
  value = google_compute_instance.instance.network_interface[0].access_config[0].nat_ip
}

output "id" {
  value = google_compute_instance.instance.id
}

output "name" {
  value = google_compute_instance.instance.name
}
