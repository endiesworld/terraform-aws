output "vpc_id" {
  value = module.myapp-vpc.vpc_id
}

output "private_subnets" {
  value = module.myapp-vpc.private_subnets
}

output "public_subnets" {
  value = module.myapp-vpc.public_subnets
}

output "nat_gateway_ids" {
  value = module.myapp-vpc.natgw_ids
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}
