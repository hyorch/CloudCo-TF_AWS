variable "aws-region" {
  default = "eu-west-1" #Ireland
}

variable "bucket-name" {
  default = "cloudco-demo-tf-state"
}

variable "bucket-encryption" {
  default = "AES256"
}

variable "dynamodb-table" {
  default = "terraform-locks"  
}