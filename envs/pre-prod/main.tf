module "network" {
  source = "../../modules/network"

  env                 = var.env
  public_subnet_count = var.public_subnets_count
  common_tags         = var.common_tags

}

module "compute" {
  source         = "../../modules/compute"
  env            = var.env
  security_group_id = module.network.security_group_id
  subnet_ids     = module.network.public_subnet_ids
  instance_count = var.instance_count
  common_tags    = var.common_tags

}