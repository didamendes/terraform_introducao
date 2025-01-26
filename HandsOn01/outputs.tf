output "droplet_ip" {
  value = digitalocean_droplet.mv_aula[*].ipv4_address
}