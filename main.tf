terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
    }
    template = {
      version = "2.2.0"
      source  = "hashicorp/template"
    }
  }
  required_version = ">= 1.0"
}

# https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs
provider "libvirt" {
  uri = "qemu:///system"
}

###
### Volumes used by nodes
###
resource "libvirt_volume" "ubuntu-2404-noble" {
  name   = "${var.project-name}-ubuntu-2404-cloudimg.img"
  source = var.node-os-image
  format = "qcow2"
}
