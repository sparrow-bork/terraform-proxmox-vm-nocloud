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
  default     = "ssd"
}

variable "user_data" {
  description = "The user-data config to supply for cloud-init"
  type        = string
  default     = ""
}

variable "vm_onboot" {
  description = "Whether to have the VM startup after PVE node starts"
  type        = bool
  default     = false
}

variable "vm_state" {
  description = "The state of the VM after creation"
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

  validation {
    condition     = var.vm_count > 0
    error_message = "Variable vm_count cannot be less than 1."
  }
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
  validation {
    condition     = var.resource_allocation.cores >= var.resource_allocation.vcpus
    error_message = "CPU cores cannot be lesser than VCPUs."
  }
  validation {
    condition     = var.resource_allocation.cores > 0
    error_message = "CPU cores cannot be less than 1"
  }
  validation {
    condition     = var.resource_allocation.vcpus > 0
    error_message = "VCPUs cannot be less than 1"
  }
  validation {
    condition     = var.resource_allocation.sockets > 0
    error_message = "CPU socket cannot be less than 1"
  }
  validation {
    condition     = var.resource_allocation.memory > 0
    error_message = "Memory cannot be less than 1GB"
  }
  validation {
    condition     = var.resource_allocation.storage > 0
    error_message = "Storage cannot be less than 1GB"
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
}

variable "skip_vm_id" {
  description = "The number to increment for VM ids"
  type        = number
  default     = 0

  validation {
    condition     = var.skip_vm_id >= 0
    error_message = "Variable skip_vm_id cannot be less than 0."
  }
}