#creating vpc
module "vpc" {
  source       = "./modules/VPC"
  project_name = var.project_mod_name
  env          = var.env
  type         = var.type

}

# Creating security group
module "SG" {
  source       = "./modules/Security-Groups"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_mod_name
  ssh_access   = var.ssh_access
  http_access  = var.http_access
  env          = var.env
  type         = var.type
}

# Creating key pair
module "key-pair" {
  source   = "./modules/key-pair"
  key_name = var.key_name
}

# Creating IAM resources
module "iam" {
  source = "./modules/IAM"
}
# Creating EKS Cluster
module "eks" {
  source                = "./modules/EKS"
  master_arn            = module.iam.master_arn
  worker_arn            = module.iam.worker_arn
  public_subnet_az1_id  = module.vpc.pub_sub_AZ1_id
  public_subnet_az2_id  = module.vpc.pub_sub_AZ2_id
  env                   = var.env
  type                  = var.type
  key_name              = var.key_name
  eks_security_group_id = module.SG.eks_security_group_id
  instance_size         = var.instance_size
  project_name          = var.project_mod_name
}