# terraform-libvirt-kubernetes-cluster

Use this to quickly spin up a Kubernetes cluster using libvirt, Terraform and k0s.

Host system requirements:

- Terraform
- Libvirt with QEMU driver
  - Test with `virt-host-validate qemu`
- [k0sctl](https://github.com/k0sproject/k0sctl)
- Enough resources (CPU, memory, disk space) to run the desired amount of guests

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| libvirt | 0.8.3 |
| template | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| libvirt | 0.8.3 |

## Resources

| Name | Type |
|------|------|
| [libvirt_cloudinit_disk.cloud-init](https://registry.terraform.io/providers/dmacvicar/libvirt/0.8.3/docs/resources/cloudinit_disk) | resource |
| [libvirt_domain.k8s-nodes](https://registry.terraform.io/providers/dmacvicar/libvirt/0.8.3/docs/resources/domain) | resource |
| [libvirt_network.k8s-nodes](https://registry.terraform.io/providers/dmacvicar/libvirt/0.8.3/docs/resources/network) | resource |
| [libvirt_volume.node-disk](https://registry.terraform.io/providers/dmacvicar/libvirt/0.8.3/docs/resources/volume) | resource |
| [libvirt_volume.ubuntu-2404-noble](https://registry.terraform.io/providers/dmacvicar/libvirt/0.8.3/docs/resources/volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apt-packages | List of APT packages to install via cloud-init | `list(string)` | `[]` | no |
| libvirt-network-cidr | Network to be created in libvirt using CIDR notation | `string` | `"10.10.0.0/24"` | no |
| node-count | n/a | `number` | `1` | no |
| node-cpu | CPU allocated to each node | `number` | `1` | no |
| node-disk-size | Disk size in GB | `number` | `20` | no |
| node-memory | Memory allocated to each node in MiB | `number` | `2048` | no |
| node-os-image | OS image | `string` | `"https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"` | no |
| node-ssh-public-key | Public SSH key that you'll use to access nodes | `string` | n/a | yes |
| node-ssh-username | User created for SSH access | `string` | `"ubuntu"` | no |
| project-name | n/a | `string` | `"k0s-libvirt"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ssh-command | SSH command to access each node |
<!-- END_TF_DOCS -->
