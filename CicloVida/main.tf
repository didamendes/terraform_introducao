terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.26.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

variable "do_token" {
  type        = string
  default     = "" # Inserir o token na variavel de ambiente.
  description = "Token da Digital Ocean"
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-22-04-x64"
  name   = "vm-web"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  lifecycle {
    #create_before_destroy = true
    #prevent_destroy = true
    #ignore_changes = [ tags ]
    #replace_triggered_by = [ digitalocean_droplet.web ]
  }
}