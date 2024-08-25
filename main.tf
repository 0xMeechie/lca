module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.10.0.0/16"
  azs         = ["us-east-1a", "us-east-1b", "us-east-1c"]
  environment = var.environment

}

module "ecs" {
  source                  = "./modules/ecs/"
  rds_subnets             = module.vpc.data_subnet_ids
  environment             = var.environment
  vpc_id                  = module.vpc.vpc_id
  ecs_subnets             = module.vpc.service_subnet_ids
  public_subnets          = module.vpc.public_subnet_ids
  ecs_cluster_name        = var.ecs_cluster_name
  container_name          = var.container_name
  container_port          = var.container_port
  container_image         = var.container_image
  container_image_version = var.container_image_version
}


