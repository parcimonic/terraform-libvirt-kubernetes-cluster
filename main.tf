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
