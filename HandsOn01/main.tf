terraform {
  required_version = "~>1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "mv_aula" {
  image    = "ubuntu-22-04-x64"
  name     = "${var.droplet_name}-${count.index}"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  count    = var.vms_count
}

resource "digitalocean_firewall" "firewall_aula" {
  name = "firewall-aula"

  droplet_ids = digitalocean_droplet.mv_aula[*].id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "22"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

}

