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
  default = 2
}

variable "libvirt-network-cidr" {
  description = "Network to be created in libvirt using CIDR notation"
  type        = string
  default     = "10.10.0.0/24"
}

variable "node-disk-size" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "node-cpu" {
  description = "CPU allocated to each node"
  type        = number
  default     = 1
}

variable "node-memory" {
  description = "Memory allocated to each node in MiB"
  type        = number
  default     = 2048
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
