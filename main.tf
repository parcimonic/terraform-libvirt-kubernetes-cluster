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

resource "libvirt_cloudinit_disk" "cloud-init" {
  count = var.node-count

  name           = "${var.project-name}-cloud-init-${count.index}.iso"
  network_config = file("${path.module}/cloud-init/network_config.cfg")
  user_data = templatefile(
    "${path.module}/cloud-init/user_data.cfg",
    {
      apt-packages = var.apt-packages
      hostname     = "${var.project-name}-node-${count.index}"
      ssh-key      = var.node-ssh-public-key
      username     = var.node-ssh-username
    }
  )
}

resource "libvirt_volume" "node-disk" {
  count = var.node-count

  name           = "${var.project-name}-node-${count.index}"
  base_volume_id = libvirt_volume.ubuntu-2404-noble.id
  size           = var.node-disk-size * 1024 * 1024 * 1024

  lifecycle {
    replace_triggered_by = [
      libvirt_cloudinit_disk.cloud-init
    ]
  }
}

###
### Node network
###
resource "libvirt_network" "k8s-nodes" {
  name      = "${var.project-name}-nodes"
  mode      = "nat"
  domain    = "${var.project-name}.local"
  addresses = [var.libvirt-network-cidr]
  autostart = true

  dns {
    enabled    = true
    local_only = true
  }
}

###
### Node definition
###
resource "libvirt_domain" "k8s-nodes" {
  count = var.node-count

  name      = "${var.project-name}-node-${count.index}"
  vcpu      = var.node-cpu
  memory    = var.node-memory
  running   = true
  autostart = false
  cloudinit = libvirt_cloudinit_disk.cloud-init[count.index].id

  cpu {
    mode = "host-passthrough"
  }
  disk {
    volume_id = libvirt_volume.node-disk[count.index].id
    scsi      = true
  }
  network_interface {
    network_id     = libvirt_network.k8s-nodes.id
    hostname       = "${var.project-name}-node-${count.index}"
    addresses      = [cidrhost(var.libvirt-network-cidr, count.index + 2)]
    wait_for_lease = true
  }

  lifecycle {
    replace_triggered_by = [
      libvirt_cloudinit_disk.cloud-init
    ]
  }
}
