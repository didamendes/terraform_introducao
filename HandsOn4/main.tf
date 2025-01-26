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

resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = var.name
  region  = var.region
  version = var.k8s_version

  node_pool {
    name       = "pool-3ltike6h8"
    size       = "s-1vcpu-2gb"
    node_count = var.k8s_node_count
  }
}

variable "name" {
    type = string
    default = "k8s-aula"
}

variable "region" {
    type = string
    default = "nyc1"
}

variable "k8s_version" {
  type = string
  default = "1.31.1-do.5"
}

variable "k8s_node_count" {
  type = number
  default = 2
}