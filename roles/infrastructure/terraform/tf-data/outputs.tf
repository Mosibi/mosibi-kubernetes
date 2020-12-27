output "masters_data" {
  description = "Masters information"
  value       = libvirt_domain.k8s_master.*
}

output "workers_data" {
  description = "Worker information"
  value       = libvirt_domain.k8s_worker.*
}

output "k8s_control_data" {
  description = "k8s-control node information"
  value       = libvirt_domain.k8s_control
}
