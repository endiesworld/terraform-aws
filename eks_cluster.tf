module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.0.7"

  name               = "${var.env_prefix}-eks-cluster"
  kubernetes_version = "1.33"
  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    dev = {
      instance_types = ["t2.medium"]
      capacity_type  = "SPOT"
      desired_size   = 3
      min_size       = 1
      max_size       = 3
    }
  }

  vpc_id     = module.myapp-vpc.vpc_id
  subnet_ids = module.myapp-vpc.private_subnets

  tags = {
    Environment = "dev"
    application = "myapp"
    Terraform   = "true"
  }

#   depends_on = [module.myapp-vpc]
}






# module "eks" {
#     source  = "terraform-aws-modules/eks/aws"
#     version = "21.0.7"

#     name               = "${var.env_prefix}-eks-cluster"
#     kubernetes_version = "1.33"

#     # Optional
#     endpoint_public_access = true

#     # Optional: Adds the current caller identity as an administrator via cluster access entry
#     enable_cluster_creator_admin_permissions = true

#     # compute_config = {
#     #     enabled    = true
#     #     node_pools = ["general-purpose"]
#     # }

#     # EKS Managed Node Group(s)
#     eks_managed_node_groups = {
#         dev = {
#         # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
#         capacity_type = "ON_DEMAND"
#         # ami_type      = "AL2023_x86_64"
#         instance_types = ["t3.large"]

#         min_size     = 1
#         max_size     = 3
#         desired_size = 3
#         }
#     }

#     vpc_id     = module.myapp-vpc.vpc_id
#     subnet_ids = module.myapp-vpc.private_subnets

#     tags = {
#         Environment = "dev"
#         application = "myapp"
#         Terraform   = "true"
#     }

#     # depends_on = [module.myapp-vpc]
# }