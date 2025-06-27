module "network" {
  source = "../../modules/network"

  env                 = var.env
  public_subnet_count = var.public_subnets_count
  common_tags         = var.common_tags

}

module "compute" {
  source         = "../../modules/compute"
  env            = var.env
  subnet_ids     = module.network.public_subnet_ids
  instance_count = var.instance_count
  common_tags    = var.common_tags

}

module "logging" {
  source      = "../../modules/logging"
  vpc_id      = module.network.vpc_id
  env         = var.env
  enable     = var.enable
  common_tags = var.common_tags

}