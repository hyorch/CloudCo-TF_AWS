variable "region" { 
  type        = string
  description = "Region of the VPC"
  default = "eu-west-1"
}


variable "cluster_name" {
  type = string
  default = "EKS-Cluster-DEV" 
}

variable "instance_type" {
  description = "Instance size"
  default = "t2.micro"
}

variable "ssh_key_name" {
  description = "Name of the SSH Key stored on AWS to connect instance"
  default     = "DevOpsAWS"
}

