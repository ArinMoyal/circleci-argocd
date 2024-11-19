variable "aws_region" {
  description = "The AWS region to create resources in"
  default     = "eu-central-1"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "webapp-weather-eks-cluster"
}

variable "vpc" {
  description = "VPC in which the EKS cluster will be created"
  type        = string
  default     = "vpc-0d509965a8a40acd6"
}

variable "subnets" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
  default     = ["subnet-0967810a14a2b8d2d", "subnet-010409b798078e17a"]
}

variable "control_plane_subnet_ids" {
  description = "List of subnet IDs for the EKS control plane"
  type        = list(string)
  default     = ["subnet-0967810a14a2b8d2d", "subnet-010409b798078e17a"]
}

variable "node_groups" {
  description = "Map of EKS Node Groups"
  type = map(any)
  default = {
    eks_nodes = {
      min_capacity     = 1
      max_capacity     = 3
      desired_capacity = 2
      instance_type    = "t2.micro"
    }
  }
}
