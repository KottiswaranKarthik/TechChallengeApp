/*****************************************************
             Variables Configuration
 ****************************************************/


variable "rg_name" {
  type    = string
  default = "servin-rg"
}

variable "location" {
  type    = string
  default = "West US"
}

variable "nsg_name" {
  type    = string
  default = "servin-nsg"
}

variable "vnet_name" {
  type    = string
  default = "servin-vnet"
}

variable "cidr_range" {
  type = map
  default = {
    "vpc_cidr"    = "10.0.0.0/16"
    "subnet_cidr" = "10.0.1.0/24"
  }
}

variable "prefix" {
  type    = string
  default = "servin"
}

variable "tags" {
  type = map
  default = {
    "env" = "dev"
  }
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "vm_image" {
  type = map
  default = {
    "publisher" = "Canonical"
    "offer"     = "UbuntuServer"
    "sku"       = "18.04-LTS"
  }
}

variable "vm_password" {
  type = string
  }


