variable "project_mod_name" {
  type    = string
  default = "test-eks"
}

variable "key_name" {
  default = "kyeapnew"
}

variable "env" {
  type    = string
  default = "Dev"
}


variable "type" {
  type    = string
  default = "Production"
}
# SSH Access
variable "ssh_access" {
  type = list(string)
}

# UI Access
variable "http_access" {
  type = list(string)
}

# Worker Node instance size
variable "instance_size" {
  type = string
}

variable "region" {}