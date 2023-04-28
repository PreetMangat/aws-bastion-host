
module "networking" {
  source = "./networking"
}

module "load_balancer" {
  source            = "./load_balancer"
  public_subnet_ids = module.networking.public_subnet_ids
  vpc_id            = module.networking.vpc_id
}

module "bastion_hosts" {
  source                     = "./bastion_hosts"
  private_bastion_subnet_ids = module.networking.private_bastion_subnet_ids
  nlb_target_group_arn       = module.load_balancer.nlb_target_group_arn
  vpc_id                     = module.networking.vpc_id
  vpc_cidr                   = module.networking.vpc_cidr
}
