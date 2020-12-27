terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.2"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

###
# k8s-control
###
data "template_file" "k8s_control" {
  template = file("${path.module}/cloud-init.cfg")
  vars = {
   hostname = "k8s-control"
   domain = var.domain
  }
}

resource "libvirt_cloudinit_disk" "k8s_control" {
  name           = "k8s_control.iso"
  user_data      = data.template_file.k8s_control.rendered
  pool           = "default"
}

resource "libvirt_volume" "k8s_control" {
  name = "k8s-control.qcow2"
  pool = "default"
  source = var.installation_image
  format = "qcow2"
}

resource "libvirt_domain" "k8s_control" {
  name   = "k8s-control"
  memory = "1024"
  vcpu   = 1

  cloudinit = libvirt_cloudinit_disk.k8s_control.id

  disk {
    volume_id = libvirt_volume.k8s_control.id
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }

  network_interface {
    network_name = "default"
    wait_for_lease = true
  }
}

###
# k8s-masters
###
data "template_file" "k8s_master" {
  count    = var.master_count
  template = file("${path.module}/cloud-init.cfg")
  vars = {
    hostname = "k8s-master${count.index + 1}"
    domain   = var.domain
  }
}

resource "libvirt_cloudinit_disk" "k8s_master" {
  count     = var.master_count
  name      = "k8s_master${count.index + 1}.iso"
  user_data = data.template_file.k8s_master[count.index].rendered
  pool      = "default"
}

resource "libvirt_volume" "k8s_master" {
  count  = var.master_count
  name   = "k8s-master${count.index + 1}.qcow2"
  pool   = "default"
  source = var.installation_image
  format = "qcow2"
}

resource "libvirt_domain" "k8s_master" {
  count  = var.master_count
  name   = "k8s-master${count.index + 1}"
  memory = "4096"
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.k8s_master[count.index].id

  disk {
    volume_id = libvirt_volume.k8s_master[count.index].id
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }

  network_interface {
    network_name = "default"
    wait_for_lease = true
  }
}

###
# k8s-workers
###
data "template_file" "k8s_worker" {
  count    = var.worker_count
  template = file("${path.module}/cloud-init.cfg")
  vars = {
    hostname = "k8s-worker${count.index + 1}"
    domain = var.domain
  }
}

resource "libvirt_cloudinit_disk" "k8s_worker" {
  count    = var.worker_count
  name      = "k8s_worker${count.index + 1}.iso"
  user_data = data.template_file.k8s_worker[count.index].rendered
  pool      = "default"
}

resource "libvirt_volume" "k8s_worker" {
  count    = var.worker_count
  name = "k8s-worker${count.index + 1}.qcow2"
  pool = "default"
  source = var.installation_image
  format = "qcow2"
}

resource "libvirt_domain" "k8s_worker" {
  count    = var.worker_count
  name   = "k8s-worker${count.index + 1}"
  memory = "4096"
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.k8s_worker[count.index].id

  disk {
    volume_id = libvirt_volume.k8s_worker[count.index].id
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }

  network_interface {
    network_name = "default"
    wait_for_lease = true
  }
}
