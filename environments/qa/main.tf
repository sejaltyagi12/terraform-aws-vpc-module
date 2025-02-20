module "vpc" {
  source = "../../module/vpc"

  vpc_config    = var.vpc_config
  subnet_config = var.subnet_config
}