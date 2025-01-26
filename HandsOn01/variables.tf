variable "droplet_name" {
  default     = "mv-aula"
  type        = string
  description = "Nome inicial do droplet"
}

variable "droplet_region" {
  default     = "nyc1"
  type        = string
  description = "Região que vai ser criada o droplet"
}

variable "droplet_size" {
  default     = "s-1vcpu-2gb"
  type        = string
  description = "Perfil de maquina dos droplet"
}

variable "ssh_key" {
  default     = "aula-terraform"
  type        = string
  description = "Chave do SSH que vai ser usado"
}

variable "token" {
  type        = string
  description = "Token da API da  Digital Ocean"
}

variable "vms_count" {
  default     = 1
  type        = number
  description = "Quantidade de maquinas"
}