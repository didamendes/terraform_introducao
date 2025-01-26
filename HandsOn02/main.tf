terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  default = "" # Inserir o token na variavel de ambiente.
}


provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "vm_labs" {
  image    = "ubuntu-22-04-x64"
  name     = "vm-labs"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.ssh.id]
}

resource "digitalocean_ssh_key" "ssh" {
  name       = "aula-terraform-diogo"
  public_key = file("C:/Users/didam/.ssh/aula-terraform.pub")
}

output "ip" {
  value = digitalocean_droplet.vm_labs.ipv4_address
}

output "id" {
  value = digitalocean_droplet.vm_labs.id
}