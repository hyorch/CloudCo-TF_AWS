variable "region" { 
  type        = string
  description = "Region of the VPC"
}

variable "vpc_environment"{
  description = "Environtment where running this Terraform"  
}

variable "server_name" {
  type = string
  default = "WebServer Name" 
}

variable "instance_type" {
  description = "Web instance size"
  default = "t2.micro"
}

variable "ssh_key_name" {
  description = "Name of the SSH Key stored on AWS to connect instance"
  default     = "DevOpsAWS"
}

variable "http_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

variable "ssh_port" {
  description = "SSH port"
  default     = 22
}