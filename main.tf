provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source   = "./modules/subnets"
  vpc_id   = module.vpc.vpc_id
}

module "security_groups" {
  source   = "./modules/security_groups"
  vpc_id   = module.vpc.vpc_id
}

module "key_pair" {
  source = "./modules/key_pair"
}

module "instances" {
  source              = "./modules/instances"
  public_subnet_id    = module.subnets.public_subnet_id
  private_subnet_id   = module.subnets.private_subnet_id
  security_group_ids  = [module.security_groups.instance_sg_id, module.security_groups.private_instance_sg_id]
  key_name            = module.key_pair.key_name
}
module "nat" {
  source               = "./modules/nat"
  public_subnet_id     = module.subnets.public_subnet_id
  private_subnet_id    = module.subnets.private_subnet_id
  private_route_table_id = module.subnets.private_route_table_id
}

