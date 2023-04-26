
module "networking" {
  source = "./networking"
}

module "load_balancer" {
  source            = "./load_balancer"
  public_subnet_ids = module.networking.public_subnet_ids
  vpc_id            = module.networking.vpc_id
}
