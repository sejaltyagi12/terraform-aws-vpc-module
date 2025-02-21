variable "vpc_config" {}
variable "subnet_config" {}
variable "security_group_config" {}

module "vpc" {
  source = "../../module/vpc"

  vpc_config            = var.vpc_config
  subnet_config         = var.subnet_config
  security_group_config = var.security_group_config
}