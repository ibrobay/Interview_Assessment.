variable "region" {
default = "us-west-2"
}
variable "key_path" {
  description = "SSH Public Key path"
  default = "~/.ssh/id_rsa.pub"
}
variable "key_path_priv" {
  description = "SSH private Key path"
  default = "~/.ssh/id_rsa"
}
variable "instance_type" {}
variable "instance_key" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
