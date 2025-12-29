provider "aws" {
  region = "ap-south-1"
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.0"

  name = "banking-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24","10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24","10.0.102.0/24"]

  enable_nat_gateway = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "banking-eks"
  cluster_version = "1.29"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      min_size       = 2
      max_size       = 5
      desired_size   = 2
      instance_types = ["t3.medium"]
    }
  }
}
