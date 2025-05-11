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

variable "node-count" {
  type    = number
  default = 1
}

variable "node-ssh-username" {
  description = "User created for SSH access"
  type        = string
  default     = "ubuntu"
}

# https://cloudinit.readthedocs.io/en/latest/reference/modules.html#ssh-import-id
variable "node-ssh-public-key" {
  description = "Public SSH key that you'll use to access nodes"
  type        = string
  # example: node-ssh-public-key = "gh:parcimonic"
}

variable "apt-packages" {
  description = "List of APT packages to install via cloud-init"
  type        = list(string)
  default     = []
}
