output "ssh-command" {
  description = "SSH command to access each node"
  value       = <<EOT
  %{for ip in flatten(libvirt_domain.k8s-nodes[*].network_interface[0].addresses)~}
  ssh ${var.node-ssh-username}@${ip}
  %{endfor}
  EOT
}
