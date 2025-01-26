terraform {
  required_version = "~>1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "ssh" {
  name = "aula-terraform"
}

resource "digitalocean_droplet" "vm_aula" {
  image    = "ubuntu-22-04-x64"
  name     = "maquina-aula"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh.id]

  #  provisioner "local-exec" {
  #    command = "echo Máquina com IP ${self.ipv4_address} criada"
  #  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("~/.ssh/aula-terraform")
    host        = digitalocean_droplet.vm_aula.ipv4_address
  }

  provisioner "remote-exec" {
    inline = ["apt update", "apt install curl -y", "apt install nginx -y"]
  }

}

variable "do_token" {
  default = "" # Inserir o token na variavel de ambiente.
}