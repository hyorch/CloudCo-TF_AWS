variable "aws-region" {
  default = "eu-west-1" #Ireland
}

variable "bucket-name" {
  description = "Bucket name to store Terraform State"
  default     = "cloudco-demo-tf-state"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  default     = "Jenkins-Ubuntu"
}

variable "instance_type" {
  description = "Jenkins instance size"
  default = "t2.micro"
}

variable "ssh_key_name" {
  description = "Name of the SSH Key stored on AWS to connect instance"
  default     = "DevOpsAWS"
}

variable "ssh_key_file" {
  description = "Local PATH to SSH Key"
  default = "~/.ssh/DevOpsAWS.pem"
  
}

variable "http_jenkins_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

variable "ssh_port" {
  description = "SSH port"
  default     = 22
}