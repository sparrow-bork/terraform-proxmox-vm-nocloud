# terraform-proxmox-vm-nocloud
Terraform module for provisioning proxmox VM with nocloud

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.1-rc3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.11.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 3.0.1-rc3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_cloud_init_disk.this](https://registry.terraform.io/providers/Telmate/proxmox/3.0.1-rc3/docs/resources/cloud_init_disk) | resource |
| [proxmox_vm_qemu.this](https://registry.terraform.io/providers/Telmate/proxmox/3.0.1-rc3/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootable_iso"></a> [bootable\_iso](#input\_bootable\_iso) | The ISO file name to boot from | `string` | `"ssd:iso/talos-nocloud-amd64.iso"` | no |
| <a name="input_name"></a> [name](#input\_name) | The suffix to use for the cloud-init and VM | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The network configuration for ip cidr, hostnum, gateway, and dns nameserver | <pre>object({<br>    ip_subnet       = optional(string, "10.255.0.0")<br>    ip_hostnum      = optional(number, 200)<br>    ip_prefix       = optional(number, 24)<br>    ip_gateway      = string<br>    dns_nameservers = optional(list(string), ["1.1.1.1", "8.8.8.8"])<br>  })</pre> | n/a | yes |
| <a name="input_resource_allocation"></a> [resource\_allocation](#input\_resource\_allocation) | The resource amount to allocation for CPU, Memory, and Storage | <pre>object({<br>    cores   = optional(number, 1)<br>    vcpus   = optional(number, 1)<br>    sockets = optional(number, 1)<br>    memory  = optional(number, 256)<br>    storage = optional(string, 128)<br>  })</pre> | <pre>{<br>  "cores": 1,<br>  "memory": 256,<br>  "sockets": 1,<br>  "storage": 128,<br>  "vcpus": 1<br>}</pre> | no |
| <a name="input_skip_vm_id"></a> [skip\_vm\_id](#input\_skip\_vm\_id) | The number to increment for VM ids | `number` | `0` | no |
| <a name="input_storage_name"></a> [storage\_name](#input\_storage\_name) | The storage to deploy to | `string` | `"ssd"` | no |
| <a name="input_target_node"></a> [target\_node](#input\_target\_node) | The target node to deploy to | `string` | `"pve"` | no |
| <a name="input_template_to_clone"></a> [template\_to\_clone](#input\_template\_to\_clone) | Template name to clone for the VM | `string` | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | n/a | `any` | n/a | yes |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | Number of VMs to create | `number` | `1` | no |
| <a name="input_vm_onboot"></a> [vm\_onboot](#input\_vm\_onboot) | Whether to have the VM startup after PVE node starts | `bool` | `false` | no |
| <a name="input_vm_protection"></a> [vm\_protection](#input\_vm\_protection) | Enable/disable the VM protection from being removed | `bool` | `false` | no |
| <a name="input_vm_state"></a> [vm\_state](#input\_vm\_state) | The state of the VM | `string` | `"running"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->