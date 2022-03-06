variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe"
}

variable "vm_size" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "Standard_D2_v2"  
}

variable "vm_sizeworker" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "Standard_D1_v2" 
}
