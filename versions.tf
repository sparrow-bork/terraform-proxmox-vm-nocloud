terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.11.2"
    }
  }
}