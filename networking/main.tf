module "vpc" {
  source = "./vpc"
}

module "public_subnets" {
  source   = "./public_subnets"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
  igw_id   = module.vpc.igw_id
}

module "private_subnets" {
  source   = "./private_subnets"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
}
