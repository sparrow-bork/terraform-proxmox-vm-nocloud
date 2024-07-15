

resource "proxmox_cloud_init_disk" "this" {
  count = var.vm_count

  name     = "${var.name}-${count.index}"
  pve_node = var.target_node
  storage  = var.storage_name

  meta_data = yamlencode({
    instance_id    = sha1(var.name)
    local-hostname = "${var.name}-${count.index}"
  })

  user_data = var.user_data

  network_config = yamlencode({
    version = 1
    config = [{
      type = "physical"
      name = "eth0"
      subnets = [{
        type            = "static"
        address         = "${cidrhost("${var.network.ip_subnet}/${var.network.ip_prefix}", 200 + var.skip_vm_id + count.index)}/${var.network.ip_prefix}" # "${cidrhost(var.network.ip_cidr, 200 + count.index)}/24"
        gateway         = var.network.ip_gateway
        dns_nameservers = var.network.dns_nameservers
      }]
    }]
  })
}

resource "proxmox_vm_qemu" "this" {
  count = var.vm_count

  name = "${var.name}-${count.index}"
  desc = <<-EOF
    ${var.name} VM  
    Talos Linux Kubernetes Cluster
  EOF

  vmid        = 5000 + var.skip_vm_id + count.index
  target_node = var.target_node

  # template to clone
  clone      = var.template_to_clone
  full_clone = true

  onboot     = var.vm_onboot
  vm_state   = var.vm_state
  protection = var.vm_protection

  cpu = "x86-64-v2-AES"

  cores   = 2
  vcpus   = 2
  sockets = 1
  memory  = 2560

  scsihw  = "virtio-scsi-single"
  os_type = "cloud-init" # cloud-init, # ubuntu, # centos

  disks {
    ide {
      ide2 {
        cdrom {
          iso = var.bootable_iso
        }
      }
    }
    scsi {
      scsi0 {
        cdrom {
          iso = proxmox_cloud_init_disk.this[count.index].id
        }
      }
      scsi1 {
        disk {
          emulatessd = false
          format     = "qcow2"
          iothread   = true
          replicate  = true
          size       = "${var.resource_allocation.storage}G"
          storage    = var.storage_name
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
}
