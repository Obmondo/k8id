variable "environment" {
  type        = string
  description = "Env of k8s cluster"
}

variable "cluster_name" {
  type        = string
  description = "K8s cluster name"
}

variable "subzone_id" {
  type        = string
  description = "Zone ID for subdomain"
}

variable "external_dns_zones" {
  type        = list(string)
  description = "Zone ID for subdomain"
  default     = []
}
