variable "name" {
  description = "The suffix to use for the cloud-init and VM"
  type        = string
}

variable "target_node" {
  description = "The target node to deploy to"
  type        = string
  default     = "pve"
}

variable "storage_name" {
  description = "The storage to deploy to"
  type        = string
  default     = "ssd" # or local-lvm

  validation {
    condition     = contains(["local-lvm", "ssd"], var.storage_name)
    error_message = "Valid values for var: storage_name are (local-lvm, ssd)."
  }
}

variable "user_data" {}

variable "template_to_clone" {
  description = "Template name to clone for the VM"
  type        = string
  default     = null
}

variable "vm_onboot" {
  description = "Whether to have the VM startup after PVE node starts"
  type        = bool
  default     = false
}

variable "vm_state" {
  description = "The state of the VM"
  type        = string
  default     = "running"

  validation {
    condition     = contains(["running", "stopped", "started"], var.vm_state)
    error_message = "Valid values for var: vm_state are (running, stopped, started)."
  }
}

variable "vm_protection" {
  description = "Enable/disable the VM protection from being removed"
  type        = bool
  default     = false
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "resource_allocation" {
  description = "The resource amount to allocation for CPU, Memory, and Storage"
  type = object({
    cores   = optional(number, 1)
    vcpus   = optional(number, 1)
    sockets = optional(number, 1)
    memory  = optional(number, 256)
    storage = optional(string, 128)
  })
  default = {
    cores   = 1
    vcpus   = 1
    sockets = 1
    memory  = 256
    storage = 128
  }
}

variable "network" {
  description = "The network configuration for ip cidr, hostnum, gateway, and dns nameserver"
  type = object({
    ip_subnet       = optional(string, "10.255.0.0")
    ip_hostnum      = optional(number, 200)
    ip_prefix       = optional(number, 24)
    ip_gateway      = string
    dns_nameservers = optional(list(string), ["1.1.1.1", "8.8.8.8"])
  })
}

variable "bootable_iso" {
  description = "The ISO file name to boot from"
  type        = string
  default     = "ssd:iso/talos-nocloud-amd64.iso"
}

variable "skip_vm_id" {
  description = "The number to increment for VM ids"
  type        = number
  default     = 0
}