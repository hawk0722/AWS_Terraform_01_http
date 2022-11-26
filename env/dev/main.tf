
module "network" {
  source = "../../modules/network"

  region     = var.region
  project    = var.project
  env        = var.env
  cidr_block = var.cidr_block

}

module "instance" {
  source = "../../modules/instance"

  project = var.project
  env     = var.env

  public_subnet_1a_id = module.network.public_subnet_1a_id
  sg_web_id           = module.network.sg_web_id

}
