output "vm_intern_ip" {
  value = google_compute_instance.vm.network_interface[0].network_ip
}

output "vm_extern_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "vm_username" {
  value = google_compute_instance.vm.metadata[0].ssh-keys
}