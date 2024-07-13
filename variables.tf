variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "profile" {
  type = string
  description = "AWS profile"
}