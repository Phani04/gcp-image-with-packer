packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

source "googlecompute" "ubuntu-nginx" {
  account_file = var.account_file
  image_name = "phani-my-custom-ubuntu-image-{{timestamp}}"
  project_id      = "packer-build-414007"
  source_image_family = "ubuntu-2004-lts"
  zone            = "us-central1-a"
  ssh_username    = "packer"
  machine_type    = "e2-medium"
}

build {
  sources = ["source.googlecompute.ubuntu-nginx"]

  provisioner "shell" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y software-properties-common",
    "sudo add-apt-repository --yes --update ppa:ansible/ansible",
    "sudo apt-get install -y ansible"
  ]
}

  provisioner "ansible-local" {
  playbook_file = "${var.software}.yml"
}
}
