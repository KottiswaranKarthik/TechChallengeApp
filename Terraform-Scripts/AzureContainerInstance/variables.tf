/*****************************************************
             Variables Configuration
 ****************************************************/


variable "rg_name" {
  type    = string
  default = "servin-rg"
}

variable "tags" {
  type = map
  default = {
    "env" = "dev"
  }
}

variable "location" {
  type    = string
  default = "West US"
}

variable "Db_Password" {
  type = string
}

variable "servian-aci" {
  type = map
  default = {
    "name"             = "servian-techchallenge"
    "dns_label"        = "servian-techchallenge"
    "container1_name"  = "postgres"
    "container1_image" = "postgres:latest"
    "container2_name"  = "servian-techchallenge"
    "container2_image" = "syeaman1693/servian-techchallenge:latest"
    "DbHost"           = "0.0.0.0"
    "ListenHost"       = "0.0.0.0"
    "ListenPort"       = "80"
  }
}
