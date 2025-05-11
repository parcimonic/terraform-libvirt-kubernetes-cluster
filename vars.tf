variable "project-name" {
  type    = string
  default = "k0s-libvirt"
}

variable "node-os-image" {
  description = "OS image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  # Example using a local file to avoid redownload every time the resource is destroyed-created:
  # node-os-image = "./noble-server-cloudimg-amd64.img"
}
